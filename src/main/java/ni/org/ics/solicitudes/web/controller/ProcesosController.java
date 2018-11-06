package ni.org.ics.solicitudes.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Account;
import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.Deliver;
import ni.org.ics.solicitudes.domain.Insumo;
import ni.org.ics.solicitudes.domain.Item;
import ni.org.ics.solicitudes.domain.Purchase;
import ni.org.ics.solicitudes.domain.audit.AuditTrail;
import ni.org.ics.solicitudes.domain.relationship.UserCenter;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.AuditTrailService;
import ni.org.ics.solicitudes.service.CentroService;
import ni.org.ics.solicitudes.service.CompraService;
import ni.org.ics.solicitudes.service.CuentaService;
import ni.org.ics.solicitudes.service.EntregasService;
import ni.org.ics.solicitudes.service.InsumosService;
import ni.org.ics.solicitudes.service.ItemService;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.UserSistema;


@Controller
@RequestMapping("/procesos/*")
public class ProcesosController {
	private static final Logger logger = LoggerFactory.getLogger(ProcesosController.class);
	
	
	@Resource(name="centroService")
	private CentroService centroService;
	
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;
	
	@Resource(name="compraService")
	private CompraService compraService;
	
	@Resource(name="cuentaService")
	private CuentaService cuentaService;
	
	@Resource(name="insumosService")
	private InsumosService insumosService;
	
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
	
	@Resource(name="entregasService")
	private EntregasService entregasService;
	
	@Resource(name="itemService")
	private ItemService itemService;
	

	@RequestMapping(value = "/compras/", method = RequestMethod.GET)
    public String obtenerCompras(Model model) throws ParseException { 	
    	logger.debug("Mostrando Pagina de busqueda de compras en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Center> centros = this.centroService.getCentrosActivosDelusuario(usuarioActual.getUsername());
    	model.addAttribute("centros", centros);
    	List<String> proveedores = this.compraService.getProveedores();
		model.addAttribute("proveedores", proveedores);
		List<Account> cuentas = this.cuentaService.getActiveCuentas();
		model.addAttribute("cuentas", cuentas);
		List<Insumo> insumos = this.insumosService.getInsumosActivos();
		model.addAttribute("insumos", insumos);
    	return "procesos/searchCompras";
	}
	
	
	@RequestMapping(value = "/compras/", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody List<Purchase> fetchPurchases(@RequestParam(value = "numFactura", required = false) String numFactura,
    		@RequestParam(value = "fechaCompraRange", required = false, defaultValue = "") String fechaCompraRange,
    		@RequestParam(value = "lugarCompra", required = true) String lugarCompra,
    		@RequestParam(value = "proveedor", required = true) String proveedor,
    		@RequestParam(value = "cuenta", required = true) String cuenta,
    		@RequestParam(value = "insumo", required = true) String insumo
    		) throws ParseException {
        logger.info("Obteniendo compras");
        Long desde = null;
        Long hasta = null;
        if (!fechaCompraRange.matches("")) {
        	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        	desde = formatter.parse(fechaCompraRange.substring(0, 10)).getTime();
        	hasta = formatter.parse(fechaCompraRange.substring(fechaCompraRange.length()-10, fechaCompraRange.length())).getTime();
        }
        UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        List<Purchase> datos = this.compraService.getComprasFiltro(numFactura,desde,hasta,lugarCompra,proveedor,cuenta,insumo,usuarioActual.getUsername());
        
        if (datos == null){
        	logger.debug("Nulo");
        }
        else {
        	for (Purchase compra:datos) {
        		Center centroCompra = this.centroService.getCentro(compra.getLugarCompra());
        		compra.setLugarCompra(centroCompra.getNombreCentro());
        	}
        }
        return datos;
    }
	
	@RequestMapping("/compras/{idCompra}/")
    public ModelAndView showCompra(@PathVariable("idCompra") String idCompra) {
    	ModelAndView mav;
    	boolean esactiva = false;
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Purchase compra = this.compraService.getPurchase(idCompra,usuarioActual.getUsername());
    	
        if(compra==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("procesos/viewCompra");
        	Center centroCompra = this.centroService.getCentro(compra.getLugarCompra());
    		compra.setLugarCompra(centroCompra.getNombreCentro());
        	mav.addObject("compra",compra);
        	if(compra.getPasive()=='0') {
        		esactiva=true;
        	}
        	mav.addObject("esactiva",esactiva);
            List<AuditTrail> bitacora = auditTrailService.getBitacora(idCompra);
            mav.addObject("bitacora",bitacora);
        }
        return mav;
    }
	
	@RequestMapping(value = "/compras/addCompra/", method = RequestMethod.GET)
	public String initAddCompraForm(Model model) {
		UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Purchase compra = new Purchase();
		model.addAttribute("compra",compra);
		List<Account> cuentas = this.cuentaService.getActiveCuentas();
    	List<Center> centros = this.centroService.getCentrosActivosDelusuarioQueCompran(usuarioActual.getUsername());
    	model.addAttribute("cuentas", cuentas);
    	model.addAttribute("centros", centros);
    	List<String> proveedores = this.compraService.getProveedores();
    	model.addAttribute("proveedores", proveedores);
    	List<String> presentaciones = this.compraService.getPresentaciones();
    	model.addAttribute("presentaciones", presentaciones);
    	model.addAttribute("hoy", new Date());
    	List<Insumo> insumos = this.insumosService.getInsumosActivos();
		model.addAttribute("insumos", insumos);
		return "procesos/addCompra";
	}
	
	@RequestMapping(value = "/compras/editCompra/{idCompra}/", method = RequestMethod.GET)
	public String initUpdateCompraForm(@PathVariable("idCompra") String idCompra, Model model) {
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Purchase compra = this.compraService.getPurchase(idCompra, usuarioActual.getUsername());
		if(compra!=null){
			model.addAttribute("compra",compra);
			List<Account> cuentas = this.cuentaService.getActiveCuentas();
    		List<Center> centros = this.centroService.getCentrosActivosDelusuarioQueCompran(usuarioActual.getUsername());
    		model.addAttribute("cuentas", cuentas);
    		model.addAttribute("centros", centros);
    		List<String> proveedores = this.compraService.getProveedores();
    		model.addAttribute("proveedores", proveedores);
    		List<String> presentaciones = this.compraService.getPresentaciones();
    		model.addAttribute("presentaciones", presentaciones);
			return "procesos/editCompra";
		}
		else{
			return "403";
		}
	}
	
	@RequestMapping("/compras/desCompra/{idCompra}/{motivo}/")
    public String disableCompra(@PathVariable("idCompra") String idCompra, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Purchase solicitud = this.compraService.getPurchase(idCompra, usuarioActual.getUsername());
    	if(solicitud!=null){
    		solicitud.setPasive('1');
    		solicitud.setMotivoCancelada(motivo);
    		this.compraService.savePurchase(solicitud);
    		redirectAttributes.addFlashAttribute("compraDeshabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreCompra", solicitud.getItem().getCodigoBrand());
    		redirecTo = "redirect:/procesos/compras/" + solicitud.getIdCompra() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Registra la compra en la base de datos*/
	@RequestMapping( value="/compras/saveCompra/", method=RequestMethod.POST)
	public ResponseEntity<String> processComprarItemForm( @RequestParam(value="idCompra", required=false, defaultValue="" ) String idCompra
	        , @RequestParam(value="idInsumo", required=true) String idInsumo
	        , @RequestParam( value="cuenta", required=true ) String cuenta
	        , @RequestParam( value="lugarCompra", required=true ) String lugarCompra
	        , @RequestParam( value="fechaCompra", required=true) String fechaCompra
	        , @RequestParam( value="proveedor", required=true ) String proveedor
	        , @RequestParam( value="numFactura", required=true ) String numFactura
	        , @RequestParam( value="cantComprada", required=true ) Integer cantComprada
	        , @RequestParam( value="presentacion", required=true ) String presentacion
	        , @RequestParam( value="contenidoPresentacion", required=true ) Float contenidoPresentacion
	        , @RequestParam( value="totalProducto", required=true ) Float totalProducto
	        , @RequestParam( value="observaciones", required=false ) String observaciones
	        )
	{
    	try{
    		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			Purchase compra = new Purchase();
			//Si el idCompra viene en blanco es una nueva compra
			if (idCompra.equals("")){
				idCompra = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
				compra.setIdCompra(idCompra);
				compra.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				compra.setRecordDate(new Date());
			}
			else{
				compra = this.compraService.getPurchase(idCompra, SecurityContextHolder.getContext().getAuthentication().getName());
			}
			compra.setItem(this.insumosService.getInsumo(idInsumo));
			compra.setCuenta(this.cuentaService.getAccount(cuenta));
			compra.setLugarCompra(lugarCompra);
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date dateCompra = formatter.parse(fechaCompra);
			compra.setFechaCompra(dateCompra);
			compra.setProveedor(proveedor);
			compra.setNumFactura(numFactura);
			compra.setCantComprada(cantComprada);
			compra.setPresentacion(presentacion);
			compra.setContenidoPresentacion(contenidoPresentacion);
			compra.setTotalProducto(totalProducto);
			compra.setObservaciones(observaciones);
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
			compra.setDeviceid(wad.getRemoteAddress());
			//Actualiza la compra
			this.compraService.savePurchase(compra);
			return createJsonResponse(compra);
    	}
		catch (DataIntegrityViolationException e){
			String message = e.getMostSpecificCause().getMessage();
			Gson gson = new Gson();
		    String json = gson.toJson(message);
			return new ResponseEntity<String>( json, HttpStatus.CREATED);
		}
		catch(Exception e){
			Gson gson = new Gson();
		    String json = gson.toJson(e.toString());
			return new ResponseEntity<String>( json, HttpStatus.CREATED);
		}
    	
	}
	
	@RequestMapping(value = "/entregas/", method = RequestMethod.GET)
    public String obtenerEntregas(Model model) throws ParseException { 	
    	logger.debug("Mostrando Pagina de busqueda de entregas en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Center> centros = this.centroService.getCentrosActivosDelusuario(usuarioActual.getUsername());
    	model.addAttribute("centros", centros);
    	List<MessageResource> sinos = messageResourceService.getCatalogo("CAT_SINO");
    	model.addAttribute("sinos", sinos);
		List<Insumo> insumos = this.insumosService.getInsumosActivos();
		model.addAttribute("insumos", insumos);
		List<UserSistema> usuarios = this.usuarioService.getActiveUsers();
    	model.addAttribute("usuarios", usuarios);
    	return "procesos/searchEntregas";
	}
	
	
	@RequestMapping(value = "/entregas/", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody List<Deliver> fetchDeliveries(@RequestParam(value = "numRecibo", required = false) String numRecibo,
    		@RequestParam(value = "fechaCompraRange", required = false, defaultValue = "") String fechaCompraRange,
    		@RequestParam(value = "usrRecibeItem", required = true) String usrRecibeItem,
    		@RequestParam(value = "entregado", required = true) String entregado,
    		@RequestParam(value = "verificado", required = true) String verificado,
    		@RequestParam(value = "insumo", required = true) String insumo
    		) throws ParseException {
        logger.info("Obteniendo entregas");
        Long desde = null;
        Long hasta = null;
        if (!fechaCompraRange.matches("")) {
        	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        	desde = formatter.parse(fechaCompraRange.substring(0, 10)).getTime();
        	hasta = formatter.parse(fechaCompraRange.substring(fechaCompraRange.length()-10, fechaCompraRange.length())).getTime();
        }
        UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        List<Deliver> datos = this.entregasService.getEntregasFiltro(numRecibo,desde,hasta,usrRecibeItem,entregado,verificado,insumo,usuarioActual.getUsername());
        
        if (datos == null){
        	logger.debug("Nulo");
        }
        return datos;
    }
	
	@RequestMapping("/entregas/{idEntrega}/")
    public ModelAndView showEntrega(@PathVariable("idEntrega") String idEntrega) {
    	ModelAndView mav;
    	boolean esactiva = false, entregada=false;
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Deliver entrega = this.entregasService.getDeliver2(idEntrega, usuarioActual.getUsername());
    	
        if(entrega==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("procesos/viewEntrega");
        	
        	mav.addObject("entrega",entrega);
        	if(entrega.getPasive()=='0') {
        		esactiva=true;
        	}
        	if(entrega.getEntregado().equals("1")) {
        		entregada=true;
        	}
        	mav.addObject("esactiva",esactiva);
        	mav.addObject("entregada",entregada);
            List<AuditTrail> bitacora = auditTrailService.getBitacora(idEntrega);
            mav.addObject("bitacora",bitacora);
        }
        return mav;
    }
	
	@RequestMapping(value = "/entregas/editEntrega/{idEntrega}/", method = RequestMethod.GET)
	public String initUpdateEntregaForm(@PathVariable("idEntrega") String idEntrega, Model model) {
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Deliver entrega = this.entregasService.getDeliver(idEntrega, usuarioActual.getUsername());
		if(entrega!=null){
			model.addAttribute("entrega",entrega);
			List<UserCenter> usuarios = this.centroService.getUsersCenter(entrega.getItemSolicitado().getSolicitud().getCtrSolicitud().getIdCentro());
    		model.addAttribute("usuarios", usuarios);
    		List<MessageResource> sinos = messageResourceService.getCatalogo("CAT_SINO");
        	model.addAttribute("sinos", sinos);
        	model.addAttribute("hoy", new Date());
			return "procesos/editEntrega";
		}
		else{
			return "403";
		}
	}
	
	@RequestMapping("/entregas/desEntrega/{idEntrega}/{motivo}/")
    public String disableEntrega(@PathVariable("idEntrega") String idEntrega, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Deliver entrega = this.entregasService.getDeliver2(idEntrega, usuarioActual.getUsername());
    	if(entrega!=null){
    		entrega.setPasive('1');
    		entrega.setMotivoCancelada(motivo);
    		this.entregasService.saveDeliver(entrega);
    		redirectAttributes.addFlashAttribute("entregaDeshabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreEntrega", entrega.getItemSolicitado().getInsumo().getCodigoBrand());
    		redirecTo = "redirect:/procesos/entregas/" + entrega.getIdEntrega() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	
	/*Registra la entrega en la base de datos*/
	@RequestMapping( value="/entregas/saveEntrega/", method=RequestMethod.POST)
	public ResponseEntity<String> processEntregarItemForm( @RequestParam(value="idEntrega", required=false, defaultValue="" ) String idEntrega
	        , @RequestParam(value="idItem", required=true) String idItem
	        , @RequestParam( value="usrRecibeItem", required=true ) String usrRecibeItem
	        , @RequestParam( value="fechaEntrega", required=true) String fechaEntrega
	        , @RequestParam( value="numRecibo", required=true ) String numRecibo
	        , @RequestParam( value="cantEntregada", required=true ) Integer cantEntregada
	        , @RequestParam( value="presentacion", required=true ) String presentacion
	        , @RequestParam( value="contenidoPresentacion", required=true ) Float contenidoPresentacion
	        , @RequestParam( value="totalProducto", required=true ) Float totalProducto
	        , @RequestParam( value="observaciones", required=true ) String observaciones
	        )
	{
    	try{
    		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    		
    		Deliver entrega = new Deliver();
			//Si el idEntrega viene en blanco es una nueva compra
			if (idEntrega.equals("")){
				idEntrega = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
				entrega.setIdCompra(idEntrega);
				entrega.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				entrega.setRecordDate(new Date());
			}
			else{
				entrega = this.entregasService.getDeliver(idEntrega, authentication.getName());
			}
			
			Item itemSolicitado = this.itemService.getItem(idItem);
			entrega.setItemSolicitado(itemSolicitado);
			entrega.setUsrRecibeItem(this.usuarioService.getUser(usrRecibeItem));
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date dateEntrega = formatter.parse(fechaEntrega);
			entrega.setEntregado("1");
			entrega.setFechaEntrega(dateEntrega);
			entrega.setNumRecibo(numRecibo);
			entrega.setCantEntregada(cantEntregada);
			entrega.setPresentacion(presentacion);
			entrega.setContenidoPresentacion(contenidoPresentacion);
			entrega.setTotalProducto(totalProducto);
			entrega.setObservaciones(observaciones);
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
			entrega.setDeviceid(wad.getRemoteAddress());
			//Actualiza la compra
			this.entregasService.saveDeliver(entrega);
			return createJsonResponse(entrega);
    	}
		catch (DataIntegrityViolationException e){
			String message = e.getMostSpecificCause().getMessage();
			Gson gson = new Gson();
		    String json = gson.toJson(message);
			return new ResponseEntity<String>( json, HttpStatus.CREATED);
		}
		catch(Exception e){
			Gson gson = new Gson();
		    String json = gson.toJson(e.toString());
			return new ResponseEntity<String>( json, HttpStatus.CREATED);
		}
    	
	}
	
	 private ResponseEntity<String> createJsonResponse( Object o ){
		    HttpHeaders headers = new HttpHeaders();
		    headers.set("Content-Type", "application/json");
		    Gson gson = new Gson();
		    String json = gson.toJson(o);
		    return new ResponseEntity<String>( json, headers, HttpStatus.CREATED );
		}
    
}
