package ni.org.ics.solicitudes.web.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
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

import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.Item;
import ni.org.ics.solicitudes.domain.Solicitud;
import ni.org.ics.solicitudes.domain.relationship.StudyCenter;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.CentroService;
import ni.org.ics.solicitudes.service.ItemService;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.SolicitudesService;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.UserSistema;


@Controller
@RequestMapping("/sols/autorizar/*")
public class AutorizarController {
	private static final Logger logger = LoggerFactory.getLogger(AutorizarController.class);
	
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
	

	/* Llamado desde el menú lista de solicitudes que tienen pendiente autorización*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerSolicitudes(Model model) throws ParseException { 	
    	logger.debug("Mostrando Pagina de busqueda de solicitudes a autorizar en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Solicitud> solicitudesSinAutorizar = this.solicitudesService.getSolicitudesporEstado(usuarioActual.getUsername(),"PENAUT");
    	model.addAttribute("solicitudes", solicitudesSinAutorizar);
    	for (Solicitud solicitud:solicitudesSinAutorizar) {
    		MessageResource mr = null;
    		String descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setEstSolicitud(descCatalogo);
    		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setTipoSolicitud(descCatalogo);
    	}
    	return "autorizar/list";
	}
	
	/* Llamado desde la lista de pendientes, muestra los datos de una solicitud específica */
	@RequestMapping("/{idSolicitud}/")
    public ModelAndView showSolicitud(@PathVariable("idSolicitud") String idSolicitud) {
    	ModelAndView mav;
    	boolean autCompleto = true;
    	boolean algunoAut = false;
    	boolean editable=false;
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
        if(solicitud==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("autorizar/viewForm");
        	if(solicitud.getEstSolicitud().equals("PENAUT")) {
        		editable=true;
        	}
        	MessageResource mr = null;
    		String descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setEstSolicitud(descCatalogo);
    		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setTipoSolicitud(descCatalogo);
        	mav.addObject("solicitud",solicitud);
            List<Item> items = this.itemService.getItemsAprobados(idSolicitud, usuarioActual.getUsername());
            for (Item item:items) {
            	if (item.getAutorizado().equals("PENAU")) autCompleto = false;
            	if (item.getAutorizado().equals("AUTPA") || item.getAutorizado().equals("AUTOR")) algunoAut = true;
        		mr = null;
        		descCatalogo = null;
        		mr = this.messageResourceService.getMensaje(item.getInsumo().getUndMedida(),"CAT_UND_MED");
        		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		if(descCatalogo!=null) item.getInsumo().setUndMedida(descCatalogo);
        		mr = this.messageResourceService.getMensaje(item.getAprobado(),"CAT_APR_INSUMO");
        		if(mr!=null)descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		if(descCatalogo!=null) item.setAprobado(descCatalogo);
        		mr = this.messageResourceService.getMensaje(item.getAutorizado(),"CAT_AUT_INSUMO");
        		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		if(descCatalogo!=null) item.setAutorizado(descCatalogo);
        		mr = this.messageResourceService.getMensaje(item.getEstItem(),"CAT_EST_ITEM");
        		if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		if(descCatalogo!=null) item.setEstItem(descCatalogo);
        	}
            mav.addObject("items",items);
            mav.addObject("autCompleto",autCompleto);
            mav.addObject("algunoAut",algunoAut);
            mav.addObject("editable",editable);
        }
        return mav;
    }
	
	/* Llamado desde la lista de items, muestra el formulario para autorizar un item */
	@RequestMapping(value = "/autorizarItem/{idItem}/", method = RequestMethod.GET)
	public String initAutorizarItemForm(@PathVariable("idItem") String idItem, Model model) {
    	logger.debug("Autorizar item");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENAUT")){
    		model.addAttribute("item", item);
    		model.addAttribute("solicitud", item.getSolicitud());
    		List<Center> centros = this.centroService.getCentrosqueCompran();
    		model.addAttribute("centros", centros);
    		List<StudyCenter> estudios = this.centroService.getAllStudyCenter(item.getSolicitud().getCtrSolicitud().getIdCentro());
    		model.addAttribute("estudios", estudios);
    		return "autorizar/enterForm";
    	}
    	else{
			return "403";
		}
	}
	
	/* Llamado desde la lista de items, cancela un item y guarda el motivo pone cancelado, no autorizado y no aprobado en el item */
	@RequestMapping("/noAutorizarItem/{idItem}/{motivo}/")
    public String deleteItem(@PathVariable("idItem") String idItem, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Item item = this.itemService.getItem(idItem,usuarioActual.getUsername());
    	if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENAUT")){
    		item.setAutorizado("NOAUT");
    		item.setEstItem("CANCEL");
    		item.setCantAutorizada(null);
    		item.setFechaAutorizado(new Date());
    		item.setMotivono(motivo);
			item.setUsrAutorizaItem(usuarioActual.getUsername());
    		this.itemService.saveItem(item);
    		redirectAttributes.addFlashAttribute("itemNoAutorizado", true);
    		redirectAttributes.addFlashAttribute("nombreItem", item.getInsumo().getCodigoBrand());
    		redirecTo = "redirect:/sols/autorizar/" + item.getSolicitud().getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/* Desde el menú acciones de la solicitud, borra la solicitud y guarda el motivo*/
	@RequestMapping("/deleteSolicitud/{idSolicitud}/{motivo}/")
    public String disableSolicitud(@PathVariable("idSolicitud") String idSolicitud, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("PENAUT")){
    		solicitud.setEstSolicitud("SOLELM");
    		solicitud.setMotivoCancelada(motivo);
    		solicitud.setPasive('1');
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirectAttributes.addFlashAttribute("solicitudDeshabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/autorizar/" + solicitud.getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/* Desde el menú acciones de la solicitud, finaliza la solicitud si no se autorizó ningun item*/
	@RequestMapping("/finalizeSolicitud/{idSolicitud}/")
    public String finalizeSolicitud(@PathVariable("idSolicitud") String idSolicitud, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("PENAUT")){
    		solicitud.setEstSolicitud("SOLFIN");
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirectAttributes.addFlashAttribute("solicitudFinalizada", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/autorizar/" + solicitud.getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/* Desde el menú acciones de la solicitud, envía la solicitud al siguiente estado (Revisión)*/
	@RequestMapping("/sendSolicitudCompra/{idSolicitud}/")
    public String sendSolicitudCompra(@PathVariable("idSolicitud") String idSolicitud, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("PENAUT")){
    		solicitud.setEstSolicitud("PENREV");
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirectAttributes.addFlashAttribute("solicitudSent", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/autorizar/" + solicitud.getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
	/* Desde el formulario de autorización de item guarda la autorización y pone pendiente de revision al item. Si estaba cancelado lo regresa a pendiente*/
	@RequestMapping( value="/autorizarItem/", method=RequestMethod.POST)
	public ResponseEntity<String> processAutorizarItemForm( @RequestParam(value="idItem", required=true) String idItem
	        , @RequestParam(value="idSolicitud", required=true) String idSolicitud
	        , @RequestParam( value="ctrCompra", required=true ) String ctrCompra
	        , @RequestParam( value="estudio", required=true ) String estudio
	        , @RequestParam( value="cantAutorizada", required=true ) Integer cantAutorizada
	        , @RequestParam( value="observaciones", required=true ) String observaciones
	        )
	{
    	try{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			Item item = this.itemService.getItem(idItem, usuarioActual.getUsername());
			if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENAUT")){
				Center centro = this.centroService.getCentro(ctrCompra);
				item.setCtrCompra(centro);
				item.setEstudio(estudio);
				item.setCantAutorizada(cantAutorizada);
				item.setFechaAutorizado(new Date());
				item.setUsrAutorizaItem(usuarioActual.getUsername());
				if(cantAutorizada==item.getCantAprobada()) {
					item.setAutorizado("AUTOR");
				}
				else {
					item.setAutorizado("AUTPA");
					item.setTotalProducto(item.getCantAutorizada()*item.getContenidoPresentacion());
				}
				item.setObservaciones(observaciones);
				item.setEstItem("PENDIE");
				item.setMotivono(null);
				WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
				item.setDeviceid(wad.getRemoteAddress());
				//Actualiza el item
				this.itemService.saveItem(item);
				return createJsonResponse(item);
			}
			else {
				Gson gson = new Gson();
			    String json = gson.toJson("No es editable, ya no tiene el estado apropiado");
				return new ResponseEntity<String>( json, HttpStatus.CREATED);
			}
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
	
	/* Desde el boton de autorización en lote pone autorizado y pendiente en el estado del item*/
	@RequestMapping( value="/autorizarItems/", method=RequestMethod.POST)
	public ResponseEntity<String> processAutorizarAllItems( @RequestParam(value="seleccionados", required=true) List<String> seleccionados
	        )
	{
    	try{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			for(String idItem:seleccionados) {
				Item item = this.itemService.getItem(idItem, usuarioActual.getUsername());
					if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENAUT")){
					item.setCantAutorizada(item.getCantAprobada());
					item.setFechaAutorizado(new Date());
					item.setUsrAutorizaItem(usuarioActual.getUsername());
					item.setAutorizado("AUTOR");
					item.setEstItem("PENDIE");
					item.setMotivono(null);
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
	
	/* Desde el boton de no autorización en lote pone no autorizado y cancelado en el estado del item ademas del motivo*/
	@RequestMapping( value="/noAutorizarItems/", method=RequestMethod.POST)
	public ResponseEntity<String> processNoAutorizarAllItems( @RequestParam(value="seleccionados", required=true) List<String> seleccionados,
			@RequestParam(value="motivo", required=true) String motivo
	        )
	{
    	try{
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			for(String idItem:seleccionados) {
				Item item = this.itemService.getItem(idItem, usuarioActual.getUsername());
				if(item!=null && item.getSolicitud().getEstSolicitud().equals("PENAUT")){
					item.setCantAutorizada(null);
					item.setFechaAutorizado(new Date());
					item.setUsrAutorizaItem(usuarioActual.getUsername());
					item.setAutorizado("NOAUT");
					item.setEstItem("CANCEL");
					item.setMotivono(motivo);
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
    
    private ResponseEntity<String> createJsonResponse( Object o ){
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Content-Type", "application/json");
	    Gson gson = new Gson();
	    String json = gson.toJson(o);
	    return new ResponseEntity<String>( json, headers, HttpStatus.CREATED );
	}
    
    
}
