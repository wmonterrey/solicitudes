package ni.org.ics.solicitudes.web.controller;



import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.Study;
import ni.org.ics.solicitudes.domain.audit.AuditTrail;
import ni.org.ics.solicitudes.domain.relationship.StudyCenter;
import ni.org.ics.solicitudes.domain.relationship.StudyCenterId;
import ni.org.ics.solicitudes.domain.relationship.UserCenter;
import ni.org.ics.solicitudes.domain.relationship.UserCenterId;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.AuditTrailService;
import ni.org.ics.solicitudes.service.CentroService;
import ni.org.ics.solicitudes.service.EstudioService;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.UserSistema;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Controlador web de peticiones relacionadas a centros
 * 
 * @author William Aviles
 */
@Controller
@RequestMapping("/admin/centers/*")
public class AdminCentrosController {
	private static final Logger logger = LoggerFactory.getLogger(AdminCentrosController.class);
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;
	
	@Resource(name="centroService")
	private CentroService centroService;
	
	@Resource(name="estudioService")
	private EstudioService estudioService;
	
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
    
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerCentros(Model model) throws ParseException { 	
    	logger.debug("Mostrando Centros en JSP");
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
    	List<Center> centros = centroService.getCentrosDelusuario(usuarioActual.getUsername());
    	model.addAttribute("centros", centros);
    	return "admin/centers/list";
	}
	
	/**
     * Custom handler for enabling/disabling a center.
     *
     * @param centro the ID of the center to enable
     * @param accion Habilitar o deshabilitar
     * @param redirectAttributes Regresa nombre de centro
     * @return a String
     */
    @RequestMapping("/habdes/{accion}/{centro}/")
    public String enableCenter(@PathVariable("centro") String centro, 
    		@PathVariable("accion") String accion, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	char hab;
    	if (accion.matches("enable1")){
    		redirecTo = "redirect:/admin/centers/";
    		hab = '0';
    		redirectAttributes.addFlashAttribute("centroHabilitado", true);
        }
        else if (accion.matches("enable2")){
        	redirecTo = "redirect:/admin/centers/{centro}/";
    		hab = '0';
    		redirectAttributes.addFlashAttribute("centroHabilitado", true);
        }
        else if(accion.matches("disable1")){
        	redirecTo = "redirect:/admin/centers/";
    		hab = '1';
    		redirectAttributes.addFlashAttribute("centroDeshabilitado", true);
        }
        else if(accion.matches("disable2")){
        	redirecTo = "redirect:/admin/centers/{centro}/";
    		hab = '1';
    		redirectAttributes.addFlashAttribute("centroDeshabilitado", true);
        }
        else{
        	return redirecTo;
        }
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		Center center = this.centroService.getCentro(centro,usuarioActual.getUsername());
    	if(center!=null){
    		center.setPasive(hab);
    		this.centroService.saveCenter(center);
    		redirectAttributes.addFlashAttribute("nombreCentro", center.getNombreCentro());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    /**
     * Custom handler for adding a center.
     * @param model Modelo enlazado a la vista
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/newCenter/", method = RequestMethod.GET)
	public String initAddCenterForm(Model model) {
    	List<Study> estudios = estudioService.getActiveEstudios();
	    model.addAttribute("estudios", estudios);
	    List<UserSistema> usuarios = usuarioService.getActiveUsers();
	    model.addAttribute("usuarios", usuarios);
	    List<MessageResource> sinos = messageResourceService.getCatalogo("CAT_SINO");
    	model.addAttribute("sinos", sinos);
		return "admin/centers/newForm";
	}
	
    
    /**
     * Custom handler for saving a center.
     * 
     * @param idCentro id del centro
     * @param nombreCentro nombre completo de centro
     * @param puedeComprar Si es comprador o no
     * @param estudios Estudios
     * @param usuarios Usuarios
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping( value="/saveCenter/", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateCenterForm( @RequestParam(value="idCentro", required=false, defaultValue="" ) String idCentro
	        , @RequestParam( value="nombreCentro", required=true ) String nombreCentro
	        , @RequestParam( value="puedeComprar", required=true, defaultValue="" ) String puedeComprar
	        , @RequestParam( value="estudios", required=false, defaultValue="") List<String> estudios
	        , @RequestParam( value="usuarios", required=false, defaultValue="") List<String> usuarios
	        )
	{
    	try{
	    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
	    	WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
	    	Center center = new Center();
			//Si el idCentro viene en blanco es un nuevo centro
			if (idCentro.equals("")){
				//Crear un nuevo centro
				idCentro = new UUID(SecurityContextHolder.getContext().getAuthentication().getName().hashCode(),new Date().hashCode()).toString();
				center.setIdCentro(idCentro);
				center.setNombreCentro(nombreCentro);
				center.setPuedeComprar(puedeComprar);
				center.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				center.setRecordDate(new Date());
				center.setDeviceid(wad.getRemoteAddress());
				//Guardar el nuevo centro
				this.centroService.saveCenter(center);
				for(String est:estudios){
					StudyCenter sc = new StudyCenter();
					sc.setEstudioCentroId(new StudyCenterId(est,idCentro));
					sc.setRecordUser(usuarioActual.getUsername());
					sc.setRecordDate(new Date());
					sc.setDeviceid(wad.getRemoteAddress());
					this.centroService.saveStudyCenter(sc);
				}
	    		for(String usr:usuarios){
	    			UserCenter uc = new UserCenter();
	    			uc.setUserCenterId(new UserCenterId(usr,idCentro));
					uc.setRecordUser(usuarioActual.getUsername());
					uc.setRecordDate(new Date());
					uc.setDeviceid(wad.getRemoteAddress());
					this.centroService.saveUserCenter(uc);
				}
			}
			//Si el //Si el idCuenta no viene en blanco hay que editar el centro
			else{
				//Recupera el centro de la base de datos
				center = centroService.getCentro(idCentro);
				center.setNombreCentro(nombreCentro);
				center.setPuedeComprar(puedeComprar);
				center.setDeviceid(wad.getRemoteAddress());
				//Actualiza el centro
				this.centroService.saveCenter(center);
			}
			return createJsonResponse(center);
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
    
    
    /**
     * Custom handler for editing a centro.
     * @param model Modelo enlazado a la vista
     * @param idCentro the ID of the centro to edit
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/editCenter/{idCentro}/", method = RequestMethod.GET)
	public String initUpdateCenterForm(@PathVariable("idCentro") String idCentro, Model model) {
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		Center center = this.centroService.getCentro(idCentro,usuarioActual.getUsername());
		if(center!=null){
			model.addAttribute("centro",center);
			List<MessageResource> sinos = messageResourceService.getCatalogo("CAT_SINO");
	    	model.addAttribute("sinos", sinos);
			return "admin/centers/editForm";
		}
		else{
			return "403";
		}
	}
    
    /**
     * Custom handler for displaying a center.
     *
     * @param idCentro the ID of the center to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping("/{idCentro}/")
    public ModelAndView showUser(@PathVariable("idCentro") String idCentro) {
    	ModelAndView mav;
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		Center center = this.centroService.getCentro(idCentro,usuarioActual.getUsername());
        if(center==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("admin/centers/viewForm");
            List<AuditTrail> bitacoraCentro = auditTrailService.getBitacora(idCentro);
            mav.addObject("bitacora",bitacoraCentro);
            List<StudyCenter> estudioscentros = this.centroService.getAllStudyCenter(idCentro);
            mav.addObject("estudioscentros", estudioscentros);
            List<UserCenter> usuarioscentros = this.centroService.getAllUsersCenter(idCentro);
        	mav.addObject("usuarioscentros", usuarioscentros);
        	List <Study> estudios = this.estudioService.getActiveEstudiosNotInCenter(idCentro);
        	mav.addObject("estudios", estudios);
        	List <UserSistema> usuarios = this.usuarioService.getActiveUsersNotInCenter(idCentro);
        	mav.addObject("usuarios", usuarios);
            mav.addObject("centro",center);
        }
        return mav;
    }
    
    /**
     * Custom handler for disabling a estudio in a centro.
     *
     * @param idEstudio the ID of the study
     * @param idCentro Centro a deshabilitar
     * @param redirectAttributes Regresa nombre de estudio
     * @return a String
     */
    @RequestMapping("/disableEstudio/{idCentro}/{idEstudio}/")
    public String disableEstudio(@PathVariable("idCentro") String idCentro, 
    		@PathVariable("idEstudio") String idEstudio, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		StudyCenter studyCenter = this.centroService.getStudyCenter(idCentro, idEstudio);
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    	if(studyCenter!=null){
    		studyCenter.setPasive('1');
    		studyCenter.setDeviceid(wad.getRemoteAddress());
    		this.centroService.saveStudyCenter(studyCenter);
    		redirecTo = "redirect:/admin/centers/{idCentro}/";
    		redirectAttributes.addFlashAttribute("estudioDeshabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreEstudio", studyCenter.getEstudio().getNombreEstudio());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    /**
     * Custom handler for enabling a estudio in a centro.
     *
     * @param idEstudio the ID of the study
     * @param idCentro Centro a habilitar
     * @param redirectAttributes Regresa nombre de estudio
     * @return a String
     */
    @RequestMapping("/enableEstudio/{idCentro}/{idEstudio}/")
    public String enableEstudio(@PathVariable("idCentro") String idCentro, 
    		@PathVariable("idEstudio") String idEstudio, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		StudyCenter studyCenter = this.centroService.getStudyCenter(idCentro, idEstudio);
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    	if(studyCenter!=null){
    		studyCenter.setPasive('0');
    		studyCenter.setDeviceid(wad.getRemoteAddress());
    		this.centroService.saveStudyCenter(studyCenter);
    		redirecTo = "redirect:/admin/centers/{idCentro}/";
    		redirectAttributes.addFlashAttribute("estudioHabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreEstudio", studyCenter.getEstudio().getNombreEstudio());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    
    /**
     * Custom handler for disabling a usuario in a centro.
     *
     * @param username the ID of the study
     * @param idCentro Centro a deshabilitar
     * @param redirectAttributes Regresa nombre de usuario
     * @return a String
     */
    @RequestMapping("/disableUsuario/{idCentro}/{username}/")
    public String disableUsuario(@PathVariable("idCentro") String idCentro, 
    		@PathVariable("username") String username, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		UserCenter userCenter = this.centroService.getUserCenter(idCentro, username);
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    	if(userCenter!=null){
    		userCenter.setPasive('1');
    		userCenter.setDeviceid(wad.getRemoteAddress());
    		this.centroService.saveUserCenter(userCenter);
    		redirecTo = "redirect:/admin/centers/{idCentro}/";
    		redirectAttributes.addFlashAttribute("usuarioDeshabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreUsuario", userCenter.getUser().getUsername());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    /**
     * Custom handler for enabling a usuario in a centro.
     *
     * @param username the ID of the study
     * @param idCentro Centro a habilitar
     * @param redirectAttributes Regresa nombre de usuario
     * @return a String
     */
    @RequestMapping("/enableUsuario/{idCentro}/{username}/")
    public String enableUsuario(@PathVariable("idCentro") String idCentro, 
    		@PathVariable("username") String username, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		UserCenter userCenter = this.centroService.getUserCenter(idCentro, username);
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    	if(userCenter!=null){
    		userCenter.setPasive('0');
    		userCenter.setDeviceid(wad.getRemoteAddress());
    		this.centroService.saveUserCenter(userCenter);
    		redirecTo = "redirect:/admin/centers/{idCentro}/";
    		redirectAttributes.addFlashAttribute("usuarioHabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreUsuario", userCenter.getUser().getUsername());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    /**
     * Custom handler for adding a estudio.
     *
     * @param idEstudio the ID of the estudio
     * @param idCentro Centro a agregar
     * @param redirectAttributes Regresa nombre de estudio
     * @return a String
     */
    @RequestMapping("/addEstudio/{idCentro}/{idEstudio}/")
    public String addEstudio(@PathVariable("idCentro") String idCentro, 
    		@PathVariable("idEstudio") String idEstudio, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		StudyCenter studyCenter = this.centroService.getStudyCenter(idCentro, idEstudio);
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    	if(studyCenter==null){
    		studyCenter = new StudyCenter();
    		studyCenter.setEstudioCentroId(new StudyCenterId(idEstudio, idCentro));
    		Study study = this.estudioService.getStudy(idEstudio);
    		studyCenter.setRecordUser(usuarioActual.getUsername());
    		studyCenter.setRecordDate(new Date());
    		studyCenter.setDeviceid(wad.getRemoteAddress());
    		this.centroService.saveStudyCenter(studyCenter);
    		redirecTo = "redirect:/admin/centers/{idCentro}/";
    		redirectAttributes.addFlashAttribute("estudioAgregado", true);
    		redirectAttributes.addFlashAttribute("nombreEstudio", study.getNombreEstudio());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
	
    
    /**
     * Custom handler for adding a usuario.
     *
     * @param username the ID of the usuario
     * @param idCentro Centro a agregar
     * @param redirectAttributes Regresa nombre de usuario
     * @return a String
     */
    @RequestMapping("/addUsuario/{idCentro}/{username}/")
    public String addUsuario(@PathVariable("idCentro") String idCentro, 
    		@PathVariable("username") String username, RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
		UserCenter userCenter = this.centroService.getUserCenter(idCentro, username);
		WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
    	if(userCenter==null){
    		userCenter = new UserCenter();
    		userCenter.setUserCenterId(new UserCenterId(username, idCentro));
    		UserSistema user = this.usuarioService.getUser(username);
    		userCenter.setRecordUser(usuarioActual.getUsername());
    		userCenter.setRecordDate(new Date());
    		userCenter.setDeviceid(wad.getRemoteAddress());
    		this.centroService.saveUserCenter(userCenter);
    		redirecTo = "redirect:/admin/centers/{idCentro}/";
    		redirectAttributes.addFlashAttribute("usuarioAgregado", true);
    		redirectAttributes.addFlashAttribute("nombreUsuario", user.getCompleteName());
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    private ResponseEntity<String> createJsonResponse( Object o )
	{
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Content-Type", "application/json");
	    Gson gson = new Gson();
	    String json = gson.toJson(o);
	    return new ResponseEntity<String>( json, headers, HttpStatus.CREATED );
	}
	
}
