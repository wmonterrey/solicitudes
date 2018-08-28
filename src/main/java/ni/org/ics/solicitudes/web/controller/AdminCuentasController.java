package ni.org.ics.solicitudes.web.controller;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Account;
import ni.org.ics.solicitudes.domain.audit.AuditTrail;
import ni.org.ics.solicitudes.service.AuditTrailService;
import ni.org.ics.solicitudes.service.CuentaService;

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
 * Controlador web de peticiones relacionadas a cuentas
 * 
 * @author William Aviles
 */
@Controller
@RequestMapping("/admin/cuentas/*")
public class AdminCuentasController {
	private static final Logger logger = LoggerFactory.getLogger(AdminCuentasController.class);
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	@Resource(name="cuentaService")
	private CuentaService cuentaService;
    
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerAccountes(Model model) throws ParseException { 	
    	logger.debug("Mostrando cuentas en JSP");
    	List<Account> cuentas = cuentaService.getCuentas();
    	model.addAttribute("cuentas", cuentas);
    	return "admin/cuentas/list";
	}
	
	
	/**
     * Custom handler for adding an cuenta.
     * @param model Modelo enlazado a la vista
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/newCuenta/", method = RequestMethod.GET)
	public String initAddAccountForm(Model model) {
    	return "admin/cuentas/enterForm";
	}
    
    /**
     * Custom handler for displaying an cuenta.
     *
     * @param idCuenta the ID of the cuenta to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping("/{idCuenta}/")
    public ModelAndView showAccount(@PathVariable("idCuenta") String idCuenta) {
    	ModelAndView mav;
    	Account cuenta = this.cuentaService.getAccount(idCuenta);
        if(cuenta==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("admin/cuentas/viewForm");
        	mav.addObject("cuenta",cuenta);
            List<AuditTrail> bitacora = auditTrailService.getBitacora(idCuenta);
            mav.addObject("bitacora",bitacora);
        }
        return mav;
    }
    
    
    
	/**
     * Custom handler for editing an cuenta.
     * @param model Modelo enlazado a la vista
     * @param idCuenta the ID of the cuenta to edit
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/editCuenta/{idCuenta}/", method = RequestMethod.GET)
	public String initUpdateAccountForm(@PathVariable("idCuenta") String idCuenta, Model model) {
		Account cuentaEditar = this.cuentaService.getAccount(idCuenta);
		if(cuentaEditar!=null){
			model.addAttribute("cuenta",cuentaEditar);
			return "admin/cuentas/enterForm";
		}
		else{
			return "403";
		}
	}
    
    /**
     * Custom handler for saving an cuenta.
     * 
     * @param idCuenta Identificador unico
     * @param codigoCuenta codigo del cuenta
     * @param nombreCuenta nombre del cuenta
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping( value="/saveCuenta/", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateUserForm( @RequestParam(value="idCuenta", required=false, defaultValue="" ) String idCuenta
	        , @RequestParam( value="nombreCuenta", required=true ) String nombreCuenta
	        )
	{
    	try{
			Account cuenta = new Account();
			//Si el idCuenta viene en blanco es un nuevo cuenta
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
			if (idCuenta.equals("")){
				//Crear un nuevo cuenta
				idCuenta = new UUID(SecurityContextHolder.getContext().getAuthentication().getName().hashCode(),new Date().hashCode()).toString();
				cuenta.setIdCuenta(idCuenta);
				cuenta.setNombreCuenta(nombreCuenta);
				cuenta.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				cuenta.setRecordDate(new Date());
				cuenta.setDeviceid(wad.getRemoteAddress());
				//Guardar el nuevo cuenta
				this.cuentaService.saveAccount(cuenta);
			}
			//Si el idCuenta no viene en blanco hay que editar el cuenta
			else{
				//Recupera el cuenta de la base de datos
				cuenta = cuentaService.getAccount(idCuenta);
				cuenta.setNombreCuenta(nombreCuenta);
				cuenta.setDeviceid(wad.getRemoteAddress());
				//Actualiza el cuenta
				this.cuentaService.saveAccount(cuenta);
			}
			return createJsonResponse(cuenta);
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
     * Custom handler for disabling an cuenta.
     *
     * @param idCuenta the ID of the cuenta to disable
     * @param redirectAttributes Regresa nombre de cuenta
     * @return a String
     */
    @RequestMapping("/desCuenta/{idCuenta}/")
    public String disableCuenta(@PathVariable("idCuenta") String idCuenta, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		Account cuenta = this.cuentaService.getAccount(idCuenta);
    	if(cuenta!=null){
    		cuenta.setPasive('1');
    		this.cuentaService.saveAccount(cuenta);
    		redirectAttributes.addFlashAttribute("cuentaDeshabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreCuenta", cuenta.getNombreCuenta());
    		redirecTo = "redirect:/admin/cuentas/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    /**
     * Custom handler for enabling an cuenta.
     *
     * @param idCuenta the ID of the cuenta to enable
     * @param redirectAttributes Regresa nombre de cuenta
     * @return a String
     */
    @RequestMapping("/habCuenta/{idCuenta}/")
    public String enableCuenta(@PathVariable("idCuenta") String idCuenta, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		Account cuenta = this.cuentaService.getAccount(idCuenta);
    	if(cuenta!=null){
    		cuenta.setPasive('0');
    		this.cuentaService.saveAccount(cuenta);
    		redirectAttributes.addFlashAttribute("cuentaHabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreCuenta", cuenta.getNombreCuenta());
    		redirecTo = "redirect:/admin/cuentas/";
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
