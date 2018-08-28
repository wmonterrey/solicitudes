package ni.org.ics.solicitudes.web.controller;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Study;
import ni.org.ics.solicitudes.domain.audit.AuditTrail;
import ni.org.ics.solicitudes.service.AuditTrailService;
import ni.org.ics.solicitudes.service.EstudioService;

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

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Controlador web de peticiones relacionadas a estudios
 * 
 * @author William Aviles
 */
@Controller
@RequestMapping("/admin/estudios/*")
public class AdminEstudiosController {
	private static final Logger logger = LoggerFactory.getLogger(AdminEstudiosController.class);
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	@Resource(name="estudioService")
	private EstudioService estudioService;
    
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerStudyes(Model model) throws ParseException { 	
    	logger.debug("Mostrando estudios en JSP");
    	List<Study> estudios = estudioService.getEstudios();
    	model.addAttribute("estudios", estudios);
    	return "admin/estudios/list";
	}
	
	
	/**
     * Custom handler for adding an estudio.
     * @param model Modelo enlazado a la vista
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/newEstudio/", method = RequestMethod.GET)
	public String initAddStudyForm(Model model) {
    	return "admin/estudios/enterForm";
	}
    
    /**
     * Custom handler for displaying an estudio.
     *
     * @param idEstudio the ID of the estudio to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping("/{idEstudio}/")
    public ModelAndView showStudy(@PathVariable("idEstudio") String idEstudio) {
    	ModelAndView mav;
    	Study estudio = this.estudioService.getStudy(idEstudio);
        if(estudio==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("admin/estudios/viewForm");
        	mav.addObject("estudio",estudio);
            List<AuditTrail> bitacora = auditTrailService.getBitacora(idEstudio);
            mav.addObject("bitacora",bitacora);
        }
        return mav;
    }
    
    
    
	/**
     * Custom handler for editing an estudio.
     * @param model Modelo enlazado a la vista
     * @param idEstudio the ID of the estudio to edit
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/editEstudio/{idEstudio}/", method = RequestMethod.GET)
	public String initUpdateStudyForm(@PathVariable("idEstudio") String idEstudio, Model model) {
		Study estudioEditar = this.estudioService.getStudy(idEstudio);
		if(estudioEditar!=null){
			model.addAttribute("estudio",estudioEditar);
			return "admin/estudios/enterForm";
		}
		else{
			return "403";
		}
	}
    
    /**
     * Custom handler for saving an estudio.
     * 
     * @param idEstudio Identificador unico
     * @param codigoEstudio codigo del estudio
     * @param nombreEstudio nombre del estudio
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping( value="/saveEstudio/", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateUserForm( @RequestParam(value="idEstudio", required=false, defaultValue="" ) String idEstudio
			, @RequestParam( value="codEstudio", required=true ) String codEstudio
	        , @RequestParam( value="nombreEstudio", required=true ) String nombreEstudio
	        )
	{
    	try{
			Study estudio = new Study();
			//Si el idEstudio viene en blanco es un nuevo estudio
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
			if (idEstudio.equals("")){
				//Crear un nuevo estudio
				idEstudio = new UUID(SecurityContextHolder.getContext().getAuthentication().getName().hashCode(),new Date().hashCode()).toString();
				estudio.setIdEstudio(idEstudio);
				estudio.setCodEstudio(codEstudio);
				estudio.setNombreEstudio(nombreEstudio);
				estudio.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				estudio.setRecordDate(new Date());
				estudio.setDeviceid(wad.getRemoteAddress());
				//Guardar el nuevo estudio
				this.estudioService.saveStudy(estudio);
			}
			//Si el idEstudio no viene en blanco hay que editar el estudio
			else{
				//Recupera el estudio de la base de datos
				estudio = estudioService.getStudy(idEstudio);
				estudio.setCodEstudio(codEstudio);
				estudio.setNombreEstudio(nombreEstudio);
				estudio.setDeviceid(wad.getRemoteAddress());
				//Actualiza el estudio
				this.estudioService.saveStudy(estudio);
			}
			return createJsonResponse(estudio);
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
     * Custom handler for disabling an estudio.
     *
     * @param idEstudio the ID of the estudio to disable
     * @param redirectAttributes Regresa nombre de estudio
     * @return a String
     */
    @RequestMapping("/desEstudio/{idEstudio}/")
    public String disableUser(@PathVariable("idEstudio") String idEstudio, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		Study estudio = this.estudioService.getStudy(idEstudio);
    	if(estudio!=null){
    		estudio.setPasive('1');
    		this.estudioService.saveStudy(estudio);
    		redirectAttributes.addFlashAttribute("estudioDeshabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreEstudio", estudio.getNombreEstudio());
    		redirecTo = "redirect:/admin/estudios/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    /**
     * Custom handler for enabling an estudio.
     *
     * @param idEstudio the ID of the estudio to enable
     * @param redirectAttributes Regresa nombre de estudio
     * @return a String
     */
    @RequestMapping("/habEstudio/{idEstudio}/")
    public String enableUser(@PathVariable("idEstudio") String idEstudio, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		Study estudio = this.estudioService.getStudy(idEstudio);
    	if(estudio!=null){
    		estudio.setPasive('0');
    		this.estudioService.saveStudy(estudio);
    		redirectAttributes.addFlashAttribute("estudioHabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreEstudio", estudio.getNombreEstudio());
    		redirecTo = "redirect:/admin/estudios/";
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
