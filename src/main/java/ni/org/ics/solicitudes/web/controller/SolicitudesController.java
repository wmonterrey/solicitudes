package ni.org.ics.solicitudes.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.Deliver;
import ni.org.ics.solicitudes.domain.Item;
import ni.org.ics.solicitudes.domain.Solicitud;
import ni.org.ics.solicitudes.domain.audit.AuditTrail;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.AuditTrailService;
import ni.org.ics.solicitudes.service.CentroService;
import ni.org.ics.solicitudes.service.EntregasService;
import ni.org.ics.solicitudes.service.ItemService;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.SolicitudesService;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.UserSistema;


@Controller
@RequestMapping("/sols/*")
public class SolicitudesController {
	private static final Logger logger = LoggerFactory.getLogger(SolicitudesController.class);
	
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
	
	@Resource(name="entregasService")
	private EntregasService entregasService;
	
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerSolicitudes(Model model) throws ParseException { 	
    	logger.debug("Mostrando Pagina de busqueda de solicitudes en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Center> centros = this.centroService.getCentrosActivosDelusuario(usuarioActual.getUsername());
    	model.addAttribute("centros", centros);
    	List<MessageResource> estados = messageResourceService.getCatalogo("CAT_EST_SOL");
    	model.addAttribute("estados", estados);
    	List<MessageResource> tipos = messageResourceService.getCatalogo("CAT_TIPO_SOL");
    	model.addAttribute("tipos", tipos);
    	List<UserSistema> usuarios = this.usuarioService.getActiveUsers();
    	model.addAttribute("usuarios", usuarios);
    	return "solicitudes/search";
	}
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody List<Solicitud> fetchSolicitudes(@RequestParam(value = "numSolicitud", required = false) Integer numSolicitud,
    		@RequestParam(value = "fecSolicitudRange", required = false, defaultValue = "") String fecSolicitudRange,
    		@RequestParam(value = "ctrSolicitud", required = true) String ctrSolicitud,
    		@RequestParam(value = "estSolicitud", required = true) String estSolicitud,
    		@RequestParam(value = "tipoSolicitud", required = true) String tipoSolicitud,
    		@RequestParam(value = "usrSolicitud", required = true) String usrSolicitud
    		) throws ParseException {
        logger.info("Obteniendo solicitudes");
        Long desde = null;
        Long hasta = null;
        if (!fecSolicitudRange.matches("")) {
        	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        	desde = formatter.parse(fecSolicitudRange.substring(0, 10)).getTime();
        	hasta = formatter.parse(fecSolicitudRange.substring(fecSolicitudRange.length()-10, fecSolicitudRange.length())).getTime();
        }
        UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        List<Solicitud> datos = solicitudesService.getSolicitudesFiltro(numSolicitud,desde,hasta,ctrSolicitud,tipoSolicitud,estSolicitud,usrSolicitud,usuarioActual.getUsername());
        if (datos == null){
        	logger.debug("Nulo");
        }
        else {
        	for (Solicitud solicitud:datos) {
        		MessageResource mr = null;
        		String descCatalogo = null;
        		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
        		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		solicitud.setEstSolicitud(descCatalogo);
        		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
        		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		solicitud.setTipoSolicitud(descCatalogo);
        	}
        }
        return datos;
    }
	
	@RequestMapping("/{idSolicitud}/")
    public ModelAndView showSolicitud(@PathVariable("idSolicitud") String idSolicitud) {
    	ModelAndView mav;
    	boolean editable=false;
    	boolean esactiva = false;
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
        if(solicitud==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("solicitudes/viewForm");
        	if(solicitud.getEstSolicitud().equals("SOLNUE")) {
        		editable=true;
        	}
        	if(solicitud.getPasive()=='0') {
        		esactiva=true;
        	}
        	mav.addObject("editable",editable);
        	mav.addObject("esactiva",esactiva);
        	MessageResource mr = null;
    		String descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setEstSolicitud(descCatalogo);
    		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		solicitud.setTipoSolicitud(descCatalogo);
        	mav.addObject("solicitud",solicitud);
            List<AuditTrail> bitacora = auditTrailService.getBitacoraSolicitud(idSolicitud);
            mav.addObject("bitacora",bitacora);
            List<Item> items = this.itemService.getItemsFiltro(idSolicitud, usuarioActual.getUsername());
            for (Item item:items) {
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
        }
        return mav;
    }
	
    @RequestMapping(value = "/addSolicitud/", method = RequestMethod.GET)
	public String initAddSolicitudForm(Model model) {
    	logger.debug("Agregar solicitud");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Center> centros = this.centroService.getCentrosActivosDelusuario(usuarioActual.getUsername());
    	model.addAttribute("centros", centros);
	    List<MessageResource> tipos = messageResourceService.getCatalogo("CAT_TIPO_SOL");
    	model.addAttribute("tipos", tipos);
    	Solicitud solicitud = new Solicitud();
    	model.addAttribute("solicitud", solicitud);
		return "solicitudes/enterForm";
	}
    
    @RequestMapping(value = "/editSolicitud/{idSolicitud}/", method = RequestMethod.GET)
	public String initUpdateSolicitudForm(@PathVariable("idSolicitud") String idSolicitud, Model model) {
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
		if(solicitud!=null && solicitud.getEstSolicitud().equals("SOLNUE")){
			model.addAttribute("solicitud",solicitud);
	    	List<Center> centros = this.centroService.getCentrosActivosDelusuario(usuarioActual.getUsername());
	    	model.addAttribute("centros", centros);
		    List<MessageResource> tipos = messageResourceService.getCatalogo("CAT_TIPO_SOL");
	    	model.addAttribute("tipos", tipos);
			return "solicitudes/enterForm";
		}
		else{
			return "403";
		}
	}
    
    
    @RequestMapping( value="/saveSolicitud/", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateSolicitudForm( @RequestParam(value="idSolicitud", required=false, defaultValue="" ) String idSolicitud
	        , @RequestParam(value="numSolicitud", required=false, defaultValue="" ) Integer numSolicitud
	        , @RequestParam( value="ctrSolicitud", required=true ) String ctrSolicitud
	        , @RequestParam( value="tipoSolicitud", required=true ) String tipoSolicitud
	        , @RequestParam( value="observaciones", required=true ) String observaciones
	        , @RequestParam( value="fecSolicitud", required=true) String fecSolicitud
	        , @RequestParam( value="fecRequerida", required=true) String fecRequerida
	        )
	{
    	try{
			Solicitud solicitud = new Solicitud();
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			UserSistema usuarioActual = this.usuarioService.getUser(authentication.getName());
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date dateSolicitud = formatter.parse(fecSolicitud);
			Date dateRequerida = formatter.parse(fecRequerida);
			//Si el idSolicitud viene en blanco es una nueva solicitud
			if (idSolicitud.equals("")){
				//Crear una nueva solicitud
				idSolicitud = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
				solicitud.setIdSolicitud(idSolicitud);
				solicitud.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				solicitud.setRecordDate(new Date());
				solicitud.setNumSolicitud(this.solicitudesService.getNextNumber());
			}
			//Si el idSolicitud no viene en blanco hay que editar la solicitud
			else{
				//Recupera la solicitud de la base de datos
				solicitud = this.solicitudesService.getSolicitud(idSolicitud);
				if(!solicitud.getEstSolicitud().equals("SOLNUE")) {
					Gson gson = new Gson();
				    String json = gson.toJson("No es editable, ya no tiene el estado apropiado");
					return new ResponseEntity<String>( json, HttpStatus.CREATED);
				}
			}
			solicitud.setObservaciones(observaciones);
			Center centro = this.centroService.getCentro(ctrSolicitud, usuarioActual.getUsername());
			solicitud.setCtrSolicitud(centro);
			solicitud.setTipoSolicitud(tipoSolicitud);
			solicitud.setUsrSolicitud(usuarioActual);
			solicitud.setEstSolicitud("SOLNUE");
			solicitud.setFecSolicitud(dateSolicitud);
			solicitud.setFecRequerida(dateRequerida);
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
			solicitud.setDeviceid(wad.getRemoteAddress());
			//Actualiza la solicitud
			this.solicitudesService.saveSolicitud(solicitud);
			return createJsonResponse(solicitud);
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
    
    
    @RequestMapping("/desSolicitud/{idSolicitud}/{motivo}/")
    public String disableSolicitud(@PathVariable("idSolicitud") String idSolicitud, @PathVariable("motivo") String motivo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("SOLNUE")){
    		solicitud.setPasive('1');
    		solicitud.setEstSolicitud("SOLELM");
    		solicitud.setMotivoCancelada(motivo);
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirectAttributes.addFlashAttribute("solicitudDeshabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/" + solicitud.getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    @RequestMapping("/sendSolicitudAprob/{idSolicitud}/")
    public String sendSolicitudAprob(@PathVariable("idSolicitud") String idSolicitud, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	List<Item> items = this.itemService.getItemsFiltro(idSolicitud, usuarioActual.getUsername());
    	if(!(items.size()>0)) {
    		redirectAttributes.addFlashAttribute("solicitudNotSent", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/" + solicitud.getIdSolicitud() + "/";
    		return redirecTo;
    	}
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("SOLNUE")){
    		solicitud.setEstSolicitud("PENAPR");
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirectAttributes.addFlashAttribute("solicitudSent", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/" + solicitud.getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    @RequestMapping("/habSolicitud/{idSolicitud}/")
    public String enableSolicitud(@PathVariable("idSolicitud") String idSolicitud, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	Solicitud solicitud = this.solicitudesService.getSolicitud(idSolicitud, usuarioActual.getUsername());
    	if(solicitud!=null && solicitud.getEstSolicitud().equals("SOLELM")){
    		solicitud.setPasive('0');
    		this.solicitudesService.saveSolicitud(solicitud);
    		redirectAttributes.addFlashAttribute("solicitudHabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreSolicitud", solicitud.getNumSolicitud());
    		redirecTo = "redirect:/sols/" + solicitud.getIdSolicitud() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    /* Llamado desde el menú lista de items pendiente de verificación*/
	@RequestMapping(value = "/verificar/"	, method = RequestMethod.GET)
    public String obtenerFaltaVerificar(Model model) throws ParseException { 	
    	logger.debug("Mostrando Pagina de busqueda de items a verificar en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	
    	List<Deliver> itemsEntregar = this.entregasService.getEntregasPendienteVerificarUsuario(usuarioActual.getUsername());
    	model.addAttribute("itemsEntregar", itemsEntregar);
    	return "verificar/list";
	}
	
    /**
     * Custom handler for verifying a deliver
     */
    @RequestMapping("/verificar/{idEntrega}/")
    public String verificarEntrega(@PathVariable("idEntrega") String idEntrega, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
		Deliver deliver = this.entregasService.getDeliver(idEntrega, usuarioActual.getUsername());
    	if(deliver!=null && deliver.getEntregado().equals("1") && deliver.getUsrRecibeItem().getUsername().equals(usuarioActual.getUsername())){
    		deliver.setVerificado("1");
    		deliver.setFechaVerificacion(new Date());
    		deliver.setDeviceid(wad.getRemoteAddress());
    		this.entregasService.saveDeliver(deliver);
    		redirecTo = "redirect:/sols/verificar/";
    		redirectAttributes.addFlashAttribute("entregaVerificada", true);
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    private ResponseEntity<String> createJsonResponse( Object o ){
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Content-Type", "application/json");
	    Gson gson = new Gson();
	    String json = gson.toJson(o);
	    return new ResponseEntity<String>( json, headers, HttpStatus.CREATED );
	}
    
    
}
