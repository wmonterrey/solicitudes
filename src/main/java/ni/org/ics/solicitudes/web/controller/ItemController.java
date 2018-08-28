package ni.org.ics.solicitudes.web.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.Insumo;
import ni.org.ics.solicitudes.domain.Item;
import ni.org.ics.solicitudes.domain.Solicitud;
import ni.org.ics.solicitudes.domain.relationship.StudyCenter;
import ni.org.ics.solicitudes.domain.relationship.UserCenter;
import ni.org.ics.solicitudes.service.CentroService;
import ni.org.ics.solicitudes.service.InsumosService;
import ni.org.ics.solicitudes.service.ItemService;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.SolicitudesService;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.UserSistema;


@Controller
@RequestMapping("/sols/items/*")
public class ItemController {
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
	
	@Resource(name="centroService")
	private CentroService centroService;
	
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;
	
	@Resource(name="solicitudesService")
	private SolicitudesService solicitudesService;
	
	@Resource(name="itemService")
	private ItemService itemService;
	
	@Resource(name="insumosService")
	private InsumosService insumosService;
	
	
    @RequestMapping(value = "/addItem/{idSolicitud}/", method = RequestMethod.GET)
	public String initAddItemForm(@PathVariable("idSolicitud") String idSolicitud, Model model) {
    	logger.debug("Agregar item");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("SOLNUE")){
    		model.addAttribute("solicitud", solicitud);
    		Item item = new Item();
    		model.addAttribute("item", item);
    		List<UserCenter> usuarios = this.centroService.getUsersCenter(solicitud.getCtrSolicitud().getIdCentro());
    		model.addAttribute("usuarios", usuarios);
    		List<Center> centros = this.centroService.getCentrosqueCompran();
    		model.addAttribute("centros", centros);
    		List<StudyCenter> estudios = this.centroService.getAllStudyCenter(solicitud.getCtrSolicitud().getIdCentro());
    		model.addAttribute("estudios", estudios);
    		List<Insumo> insumos = this.insumosService.getInsumosActivos();
    		model.addAttribute("insumos", insumos);
    		List<String> presentaciones = this.itemService.getPresentaciones();
    		model.addAttribute("presentaciones", presentaciones);
    		return "items/enterForm";
    	}
    	else{
			return "403";
		}
	}
    
    
    @RequestMapping(value = "/editItem/{idItem}/", method = RequestMethod.GET)
	public String initEditItemForm(@PathVariable("idItem") String idItem, Model model) {
    	logger.debug("Editar item");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("SOLNUE")){
    		model.addAttribute("item", item);
    		model.addAttribute("solicitud", item.getSolicitud());
    		List<UserCenter> usuarios = this.centroService.getUsersCenter(item.getSolicitud().getCtrSolicitud().getIdCentro());
    		model.addAttribute("usuarios", usuarios);
    		List<Center> centros = this.centroService.getCentrosqueCompran();
    		model.addAttribute("centros", centros);
    		List<StudyCenter> estudios = this.centroService.getAllStudyCenter(item.getSolicitud().getCtrSolicitud().getIdCentro());
    		model.addAttribute("estudios", estudios);
    		List<Insumo> insumos = this.insumosService.getInsumosActivos();
    		model.addAttribute("insumos", insumos);
    		List<String> presentaciones = this.itemService.getPresentaciones();
    		model.addAttribute("presentaciones", presentaciones);
    		return "items/enterForm";
    	}
    	else{
			return "403";
		}
	}
    
    @RequestMapping("/deleteItem/{idItem}/{motivo}/")
    public String deleteItem(@PathVariable("idItem") String idItem, @PathVariable("motivo") String motivo,
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("SOLNUE")){
    		item.setPasive('1');
    		item.setEstItem("CANCEL");
    		item.setMotivono(motivo);
    		this.itemService.saveItem(item);
    		redirectAttributes.addFlashAttribute("itemDeshabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreItem", item.getInsumo().getCodigoBrand());
    		redirecTo = "redirect:/sols/" + item.getSolicitud().getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    
    
    @RequestMapping( value="/saveItem/", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateSolicitudForm( @RequestParam(value="idItem", required=false, defaultValue="" ) String idItem
	        , @RequestParam(value="idSolicitud", required=true) String idSolicitud
			, @RequestParam(value="usrSolicitaItem", required=true) String usrSolicitaItem
	        , @RequestParam( value="ctrCompra", required=true ) String ctrCompra
	        , @RequestParam( value="estudio", required=true ) String estudio
	        , @RequestParam( value="insumo", required=true ) String insumo
	        , @RequestParam( value="cantSolicitada", required=true ) Integer cantSolicitada
	        , @RequestParam( value="presentacion", required=true ) String presentacion
	        , @RequestParam( value="contenidoPresentacion", required=true ) Float contenidoPresentacion
	        , @RequestParam( value="totalProducto", required=true ) Float totalProducto
	        , @RequestParam( value="observaciones", required=true ) String observaciones
	        )
	{
    	try{
			Item item = new Item();
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
			if(!solicitud.getEstSolicitud().equals("SOLNUE")) {
				Gson gson = new Gson();
			    String json = gson.toJson("No es editable, ya no tiene el estado apropiado");
				return new ResponseEntity<String>( json, HttpStatus.CREATED);
			}
			//Si el idItem viene en blanco es un nuevo item
			if (idItem.equals("")){
				//Crear un nuevo item
				idItem = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
				item.setIdItem(idItem);
				item.setSolicitud(solicitud);
				item.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				item.setRecordDate(new Date());
			}
			//Si el idItem no viene en blanco hay que editar el item
			else{
				//Recupera el item de la base de datos
				item = this.itemService.getItem(idItem, usuarioActual.getUsername());
			}
			item.setUsrSolicitaItem(usrSolicitaItem);
			Center centro = this.centroService.getCentro(ctrCompra);
			item.setCtrCompra(centro);
			item.setEstudio(estudio);
			Insumo insumoItem = this.insumosService.getInsumo(insumo);
			item.setInsumo(insumoItem);
			item.setCantSolicitada(cantSolicitada);
			item.setPresentacion(presentacion);
			item.setContenidoPresentacion(contenidoPresentacion);
			item.setTotalProducto(totalProducto);
			item.setAprobado("PENAP");
			item.setAutorizado("PENAU");
			item.setEstItem("PENDIE");
			item.setObservaciones(observaciones);
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
			item.setDeviceid(wad.getRemoteAddress());
			//Actualiza el item
			this.itemService.saveItem(item);
			return createJsonResponse(item);
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
