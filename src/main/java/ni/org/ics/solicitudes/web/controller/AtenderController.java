package ni.org.ics.solicitudes.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.i18n.LocaleContextHolder;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Account;
import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.Deliver;
import ni.org.ics.solicitudes.domain.Item;
import ni.org.ics.solicitudes.domain.Purchase;
import ni.org.ics.solicitudes.domain.Solicitud;
import ni.org.ics.solicitudes.domain.relationship.UserCenter;
import ni.org.ics.solicitudes.domain.util.ItemAux;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.CentroService;
import ni.org.ics.solicitudes.service.CompraService;
import ni.org.ics.solicitudes.service.CuentaService;
import ni.org.ics.solicitudes.service.EntregasService;
import ni.org.ics.solicitudes.service.InsumosService;
import ni.org.ics.solicitudes.service.ItemService;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.SolicitudesService;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.UserSistema;


@Controller
@RequestMapping("/sols/atender/*")
public class AtenderController {
	private static final Logger logger = LoggerFactory.getLogger(AtenderController.class);
	
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
	
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;
	
	@Resource(name="solicitudesService")
	private SolicitudesService solicitudesService;
	
	@Resource(name="itemService")
	private ItemService itemService;
	
	@Resource(name="insumosService")
	private InsumosService insumosService;
	
	@Resource(name="cuentaService")
	private CuentaService cuentaService;
	
	@Resource(name="compraService")
	private CompraService compraService;
	
	@Resource(name="entregasService")
	private EntregasService entregasService;
	
	@Resource(name="centroService")
	private CentroService centroService;


	/*Ver todas las solicitudes con items pendientes de revision*/
	@RequestMapping(value = "/verificar/", method = RequestMethod.GET)
    public String obtenerSolicitudes(Model model) { 	
    	logger.debug("Mostrando Pagina de busqueda de solicitudes autorizadas en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Solicitud> solicitudesAutorizadas = this.solicitudesService.getSolicitudesporEstado(usuarioActual.getUsername(),"PENREV");
    	model.addAttribute("solicitudes", solicitudesAutorizadas);
    	for (Solicitud solicitud:solicitudesAutorizadas) {
    		MessageResource mr = null;
    		String descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setEstSolicitud(descCatalogo);
    		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setTipoSolicitud(descCatalogo);
    	}
    	return "revisar/list";
	}
	
	/*Muestra los items de la solicitud pendiente de revision*/
	@RequestMapping("/verificar/{idSolicitud}/")
    public ModelAndView showSolicitud(@PathVariable("idSolicitud") String idSolicitud) {
    	ModelAndView mav;
    	boolean revCompleto = true;    	
    	
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
        if(solicitud==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("revisar/viewForm");
        	MessageResource mr = null;
    		String descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setEstSolicitud(descCatalogo);
    		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setTipoSolicitud(descCatalogo);
        	mav.addObject("solicitud",solicitud);
            List<Item> items = this.itemService.getItemsFiltroNumSolicitud(solicitud.getNumSolicitud(), usuarioActual.getUsername(),"CANCEL");
            List<ItemAux> itemsaux = new ArrayList<ItemAux>();
            for (Item item:items) {
            	ItemAux it = new ItemAux();
            	if (item.getEstItem().equals("COMPLE")||item.getEstItem().equals("ENTREG")) it.setEntregado(true);
            	if (item.getEstItem().equals("PENDIE")) revCompleto = false;
        		mr = null;
        		descCatalogo = null;
        		mr = this.messageResourceService.getMensaje(item.getInsumo().getUndMedida(),"CAT_UND_MED");
        		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		if(descCatalogo!=null) item.getInsumo().setUndMedida(descCatalogo);
        		mr = this.messageResourceService.getMensaje(item.getEstItem(),"CAT_EST_ITEM");
        		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		if(descCatalogo!=null) item.setEstItem(descCatalogo);
        		it.setItem(item);
        		itemsaux.add(it);
        	}
            mav.addObject("items",itemsaux);
            mav.addObject("revCompleto",revCompleto);
            
        }
        return mav;
    }
	
	/*Envía el item a compra desde la pagina de revisión*/
	@RequestMapping("/verificar/items/compra/{idItem}/")
    public String compraItem(@PathVariable("idItem") String idItem, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENREV")){
    		item.setEstItem("COMPRA");
    		this.itemService.saveItem(item);
    		redirectAttributes.addFlashAttribute("realizado", true);
    		redirecTo = "redirect:/sols/atender/verificar/"+ item.getSolicitud().getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Envía el item a entrega desde la pagina de revisión*/
	@RequestMapping("/verificar/items/entrega/{idItem}/")
    public String entregaItem(@PathVariable("idItem") String idItem, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENREV")){
    		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    		WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
    		Deliver entrega = new Deliver();
			String idEntrega = new UUID(usuarioActual.getUsername().hashCode(),new Date().hashCode()).toString();
			entrega.setIdEntrega(idEntrega);
			entrega.setItemSolicitado(item);
			entrega.setRecordUser(usuarioActual.getUsername());
			entrega.setRecordDate(new Date());
			entrega.setCantEntregada(item.getCantAutorizada());
			entrega.setContenidoPresentacion(item.getContenidoPresentacion());
			entrega.setTotalProducto(item.getTotalProducto());
			entrega.setPresentacion(item.getPresentacion());
			entrega.setDeviceid(wad.getRemoteAddress());
			this.entregasService.saveDeliver(entrega);
    		item.setEstItem("ENTREG");
    		this.itemService.saveItem(item);
    		redirectAttributes.addFlashAttribute("realizado", true);
    		redirecTo = "redirect:/sols/atender/verificar/"+ item.getSolicitud().getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Cancela el item desde la pagina de revisión*/
	@RequestMapping("/verificar/items/cancelar/{idItem}/{motivo}/")
    public String cancelaItem(@PathVariable("idItem") String idItem, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENREV")){
    		item.setEstItem("CANCEL");
    		item.setMotivono(motivo);
    		this.itemService.saveItem(item);
    		redirectAttributes.addFlashAttribute("realizado", true);
    		redirecTo = "redirect:/sols/atender/verificar/"+ item.getSolicitud().getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Envía todos los items a compra desde la pagina de revisión*/
	@RequestMapping( value="/verificar/items/compratodos/", method=RequestMethod.POST)
	public ResponseEntity<String> processComprarAllItems( @RequestParam(value="seleccionados", required=true) List<String> seleccionados
	        )
	{
    	try{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			for(String idItem:seleccionados) {
				Item item = this.itemService.getItem(idItem, usuarioActual.getUsername());
					if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENREV")){
					item.setEstItem("COMPRA");
					WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
					item.setDeviceid(wad.getRemoteAddress());
					//Actualiza el item
					this.itemService.saveItem(item);
				}
			}
			return createJsonResponse("success");
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
	
	
	/*Envía todos los items a entrega desde la pagina de revisión*/
	@RequestMapping( value="/verificar/items/entregatodos/", method=RequestMethod.POST)
	public ResponseEntity<String> processEntregarAllItems( @RequestParam(value="seleccionados", required=true) List<String> seleccionados
	        )
	{
    	try{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			for(String idItem:seleccionados) {
				Item item = this.itemService.getItem(idItem, usuarioActual.getUsername());
				if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENREV")){
		    		WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
		    		Deliver entrega = new Deliver();
					String idEntrega = new UUID(usuarioActual.getUsername().hashCode(),new Date().hashCode()).toString();
					entrega.setIdEntrega(idEntrega);
					entrega.setItemSolicitado(item);
					entrega.setRecordUser(usuarioActual.getUsername());
					entrega.setRecordDate(new Date());
					entrega.setCantEntregada(item.getCantAutorizada());
					entrega.setContenidoPresentacion(item.getContenidoPresentacion());
					entrega.setTotalProducto(item.getTotalProducto());
					entrega.setPresentacion(item.getPresentacion());
					entrega.setDeviceid(wad.getRemoteAddress());
					this.entregasService.saveDeliver(entrega);
					item.setEstItem("ENTREG");
					item.setDeviceid(wad.getRemoteAddress());
					//Actualiza el item
					this.itemService.saveItem(item);
				}
			}
			return createJsonResponse("success");
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
	
	/*En vía la solicitud al siguiente estado, si hay item pendientes de compra sera en compra, sino a entrega */
	@RequestMapping("/verificar/finalizarRevision/{idSolicitud}/")
    public String endSolicitudRev(@PathVariable("idSolicitud") String idSolicitud, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	String nextStat = "PENENT";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("PENREV")){
    		List<Item> items = this.itemService.getItemsFiltroNumSolicitud(solicitud.getNumSolicitud(), usuarioActual.getUsername(),"CANCEL");
    		for (Item item:items) {
    			if (item.getEstItem().equals("COMPRA")) nextStat = "PENCOM";
    		}
    		solicitud.setEstSolicitud(nextStat);
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirecTo = "redirect:/sols/atender/verificar/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Muestra la pagina de los items enviados a compra que no se ha realizado completa */
	@RequestMapping(value = "/comprar/", method = RequestMethod.GET)
    public String obtenerPendientesCompra(Model model) { 	
    	logger.debug("Mostrando Pagina de busqueda de pendientes de compra en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	MessageResource mr = null;
		String descCatalogo = null;
    	List<Item> itemsComprar = this.itemService.getItemsAComprar(usuarioActual.getUsername());
    	for (Item item:itemsComprar) {
    		mr = null;
    		descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(item.getInsumo().getUndMedida(),"CAT_UND_MED");
    		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		if(descCatalogo!=null) item.getInsumo().setUndMedida(descCatalogo);
    		mr = this.messageResourceService.getMensaje(item.getEstItem(),"CAT_EST_ITEM");
    		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		if(descCatalogo!=null) item.setEstItem(descCatalogo);
    	}
    	model.addAttribute("itemsComprar", itemsComprar);
    	return "comprar/list";
	}
	
	/*Envía el item a entrega desde la pagina de compras sin comprar. Pone el estado de la solicitud en pendiente de revision, pendiente de compra o pendiente de entrega*/
	@RequestMapping("/comprar/items/entrega/{idItem}/")
    public String entregaItemDesdeCompra(@PathVariable("idItem") String idItem, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	String nextStat = "PENENT";
    	boolean aCompra=false, aRevision=false;
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null){
    		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    		WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
    		Deliver entrega = new Deliver();
			String idEntrega = new UUID(usuarioActual.getUsername().hashCode(),new Date().hashCode()).toString();
			entrega.setIdEntrega(idEntrega);
			entrega.setItemSolicitado(item);
			entrega.setRecordUser(usuarioActual.getUsername());
			entrega.setRecordDate(new Date());
			entrega.setCantEntregada(item.getCantAutorizada());
			entrega.setContenidoPresentacion(item.getContenidoPresentacion());
			entrega.setTotalProducto(item.getTotalProducto());
			entrega.setPresentacion(item.getPresentacion());
			entrega.setDeviceid(wad.getRemoteAddress());
			this.entregasService.saveDeliver(entrega);
    		item.setEstItem("ENTREG");
    		this.itemService.saveItem(item);
    		List<Item> items = this.itemService.getItemsFiltroNumSolicitud(item.getSolicitud().getNumSolicitud(), usuarioActual.getUsername(),"CANCEL");
    		for (Item itemMod:items) {
    			if (itemMod.getEstItem().equals("COMPRA")) aCompra = true;
    			if (itemMod.getEstItem().equals("PENDIE")) aRevision = true;
    		}
    		if (aCompra) nextStat = "PENCOM";
    		if (aRevision) nextStat = "PENREV";
    		item.getSolicitud().setEstSolicitud(nextStat);
    		this.solicitudesService.saveSolicitud(item.getSolicitud());
    		redirectAttributes.addFlashAttribute("realizado", true);
    		redirecTo = "redirect:/sols/atender/comprar/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Cancela el item desde la pagina de compras*/
	@RequestMapping("/comprar/items/cancel/{idItem}/{motivo}/")
    public String cancelaItemEnCompra(@PathVariable("idItem") String idItem, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && (item.getSolicitud().getEstSolicitud().equals("PENREV")||item.getSolicitud().getEstSolicitud().equals("PENCOM"))){
    		item.setEstItem("CANCEL");
    		item.setMotivono(motivo);
    		this.itemService.saveItem(item);
    		redirectAttributes.addFlashAttribute("realizado", true);
    		redirecTo = "redirect:/sols/atender/comprar/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/*Presenta el formulario para el ingreso de una compra*/
	@RequestMapping(value = "/comprar/items/compra/{idItem}/", method = RequestMethod.GET)
	public String initComprarItemForm(@PathVariable("idItem") String idItem, Model model) {
    	logger.debug("Comprar item");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getEstItem().equals("COMPRA")){
    		model.addAttribute("item", item);
    		List<Account> cuentas = this.cuentaService.getActiveCuentas();
    		List<Center> centros = this.centroService.getCentrosActivosDelusuarioQueCompran(usuarioActual.getUsername());
    		model.addAttribute("cuentas", cuentas);
    		model.addAttribute("centros", centros);
    		List<String> proveedores = this.compraService.getProveedores();
    		model.addAttribute("proveedores", proveedores);
    		List<String> presentaciones = this.itemService.getPresentaciones();
    		model.addAttribute("presentaciones", presentaciones);
    		model.addAttribute("hoy", new Date());
    		List<MessageResource> sinos = messageResourceService.getCatalogo("CAT_SINO");
        	model.addAttribute("sinos", sinos);
    		return "comprar/enterForm";
    	}
    	else{
			return "403";
		}
	}
	
	/*Registra la compra en la base de datos*/
	@RequestMapping( value="/comprar/saveCompra/", method=RequestMethod.POST)
	public ResponseEntity<String> processComprarItemForm( @RequestParam(value="idCompra", required=false, defaultValue="" ) String idCompra
	        , @RequestParam(value="idInsumo", required=true) String idInsumo
	        , @RequestParam(value="idItem", required=true) String idItem
	        , @RequestParam( value="cuenta", required=true ) String cuenta
	        , @RequestParam( value="lugarCompra", required=true ) String lugarCompra
	        , @RequestParam( value="fechaCompra", required=true) String fechaCompra
	        , @RequestParam( value="proveedor", required=true ) String proveedor
	        , @RequestParam( value="numFactura", required=true ) String numFactura
	        , @RequestParam( value="cantComprada", required=true ) Integer cantComprada
	        , @RequestParam( value="presentacion", required=true ) String presentacion
	        , @RequestParam( value="contenidoPresentacion", required=true ) Float contenidoPresentacion
	        , @RequestParam( value="totalProducto", required=true ) Float totalProducto
	        , @RequestParam( value="remCom", required=true, defaultValue="1" ) String remCom
	        , @RequestParam( value="envEnt", required=true, defaultValue="1" ) String envEnt
	        , @RequestParam( value="observaciones", required=true ) String observaciones
	        )
	{
    	try{
    		String nextStat = "PENENT";
    		boolean aCompra=false, aRevision=false;
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			Purchase compra = new Purchase();
			idCompra = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
			compra.setIdCompra(idCompra);
			compra.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
			compra.setRecordDate(new Date());
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
			//Actualizar el item y la solicitud
			Item item = this.itemService.getItem(idItem);
			//Si el usuario eligió quitar de pendientes de compra pone a entrega
			if(remCom.equals("1")) item.setEstItem("ENTREG");
			this.itemService.saveItem(item);
			List<Item> items = this.itemService.getItemsFiltroNumSolicitud(item.getSolicitud().getNumSolicitud(), SecurityContextHolder.getContext().getAuthentication().getName(),"CANCEL");
	    	for (Item itemMod:items) {
	    		if (itemMod.getEstItem().equals("COMPRA")) aCompra = true;
	    		if (itemMod.getEstItem().equals("PENDIE")) aRevision = true;
	    	}
	    	if (aCompra) nextStat = "PENCOM";
	    	if (aRevision) nextStat = "PENREV";
	    	item.getSolicitud().setEstSolicitud(nextStat);
	    	this.solicitudesService.saveSolicitud(item.getSolicitud());
	    	//Enviar la compra a entregar si el usuario lo eligió
			if(envEnt.equals("1")) {
				Deliver entrega = new Deliver();
				String idEntrega = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
				entrega.setIdEntrega(idEntrega);
				entrega.setItemSolicitado(item);
				entrega.setIdCompra(idCompra);
				entrega.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				entrega.setRecordDate(new Date());
				entrega.setCantEntregada(compra.getCantComprada());
				entrega.setContenidoPresentacion(compra.getContenidoPresentacion());
				entrega.setTotalProducto(compra.getTotalProducto());
				entrega.setPresentacion(compra.getPresentacion());
				entrega.setDeviceid(wad.getRemoteAddress());
				this.entregasService.saveDeliver(entrega);
			}
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
	
	
	/*Muestra la pagina de los items enviados a entrega que no se ha realizado */
	@RequestMapping(value = "/entregar/", method = RequestMethod.GET)
    public String obtenerPendientesEntrega(Model model) { 	
    	logger.debug("Mostrando Pagina de busqueda de pendientes de entrega en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	MessageResource mr = null;
		String descCatalogo = null;
    	List<Deliver> itemsEntregar = this.entregasService.getEntregasPendienteUsuario(usuarioActual.getUsername());
    	for (Deliver entrega:itemsEntregar) {
    		mr = null;
    		descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(entrega.getItemSolicitado().getInsumo().getUndMedida(),"CAT_UND_MED");
    		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		if(descCatalogo!=null) entrega.getItemSolicitado().getInsumo().setUndMedida(descCatalogo);
    	}
    	model.addAttribute("itemsEntregar", itemsEntregar);
    	return "entregar/list";
	}
	
	/*Presenta el formulario para el ingreso de una entrega*/
	@RequestMapping(value = "/entregar/{idEntrega}/", method = RequestMethod.GET)
	public String initEntregaForm(@PathVariable("idEntrega") String idEntrega, Model model) {
    	logger.debug("Entregar item");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Deliver entrega = this.entregasService.getDeliver(idEntrega,usuarioActual.getUsername());
    	
    	if(entrega!=null && entrega.getEntregado().equals("0")){
    		model.addAttribute("entrega", entrega);
    		List<UserCenter> usuarios = this.centroService.getUsersCenter(entrega.getItemSolicitado().getSolicitud().getCtrSolicitud().getIdCentro());
    		model.addAttribute("usuarios", usuarios);
    		return "entregar/enterForm";
    	}
    	else{
			return "403";
		}
	}
	
	/*Registra la entrega en la base de datos*/
	@RequestMapping( value="/entregar/saveEntrega/", method=RequestMethod.POST)
	public ResponseEntity<String> processEntregarItemForm( @RequestParam(value="idEntrega", required=true ) String idEntrega
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
    		String nextStat = "SOLFIN";
    		boolean ultimo=true;
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			Item itemSolicitado = this.itemService.getItem(idItem);
			Deliver entrega = this.entregasService.getDeliver(idEntrega, authentication.getName());
			entrega.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
			entrega.setRecordDate(new Date());
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
			//Obtener todas las entregas hechas de este item
			List<Deliver> delThisItem = this.entregasService.getEntregasThisItem(idItem);
			//Suma total de producto para comparar si ya fue entregado lo autorizado, si es así, actualiza el estado del item a completo
			Float totalProductoTodasEntregas=0F;
			for (Deliver ent:delThisItem) {
				totalProductoTodasEntregas = totalProductoTodasEntregas+ent.getTotalProducto();
			}
			if(totalProductoTodasEntregas>=itemSolicitado.getTotalProducto()) {
				itemSolicitado.setEstItem("COMPLE");
				this.itemService.saveItem(itemSolicitado);
			}
			
			//Verificar si era el ultimo por entregar para actualizar la solicitud a finalizada
			List<Item> items = this.itemService.getItemsFiltroNumSolicitud(itemSolicitado.getSolicitud().getNumSolicitud(), SecurityContextHolder.getContext().getAuthentication().getName(),"CANCEL");
	    	for (Item itemMod:items) {
	    		if (!itemMod.getEstItem().equals("COMPLE")) ultimo = false;
	    	}
	    	
	    	//Si todos estan completos pone la solicitud como finalizada
	    	if (ultimo){
	    		itemSolicitado.getSolicitud().setEstSolicitud(nextStat);
	    		this.solicitudesService.saveSolicitud(itemSolicitado.getSolicitud());
	    	}
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
