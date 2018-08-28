package ni.org.ics.solicitudes;

import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.service.EmailServiceImpl;
import ni.org.ics.solicitudes.service.UsuarioService;
import ni.org.ics.solicitudes.users.model.GenericResponse;
import ni.org.ics.solicitudes.users.model.UserSistema;

/**
 * Controlador que provee los mapeos en la pagina Web para:
 * 
 * <ul>
 * <li>Pagina Principal
 * <li>Pagina de Ingreso
 * <li>Ingreso Fallido
 * <li>Pagina de Salida
 * <li>No autorizado
 * <li>No encontrado
 * <li>Reset contraseña
 * </ul>
 * 
 * @author William Aviles
 **/
@Controller
@RequestMapping("/*")
public class HomeController {
	
	@Resource(name="usuarioService")
	private UsuarioService usuarioService;
	@Resource(name="emailServiceImpl")
	private EmailServiceImpl emailServiceImpl;
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model) {
    	try {
	    	logger.info("Solicitudes Iniciado...");
    	}
    	catch(Exception e) {
    		logger.error(e.getLocalizedMessage());
    	}
    	return "home";
    }
    
    @RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "login";
	}
    
    @RequestMapping(value="/resetPassword", method = RequestMethod.GET)
	public String resetPassword(ModelMap model) {
		return "resetPassword";
	}
    
	@RequestMapping( value="resetPassword", method=RequestMethod.POST)
	public ResponseEntity<String> processResetPassForm(HttpServletRequest request, @RequestParam(value="username", required=true ) String userName
	        , @RequestParam( value="email", required=true) String email
	        )
	{
		UserSistema user = usuarioService.getUser(userName,email);
		GenericResponse genericResponse;
		if (user == null) {
		    genericResponse = new GenericResponse("error", "Usuario no encontrado/User not found");
		}
		else {
			String token = UUID.randomUUID().toString();
			usuarioService.createPasswordResetTokenForUser(user, token);
			String scheme = request.getScheme();
			String host = request.getHeader("Host");        // includes server name and server port
			String contextPath = request.getContextPath();  // includes leading forward slash

			String url = scheme + "://" + host + contextPath + "/processToken?id=" + 
				      user.getUsername() + "&token=" + token;
			String mensaje = " " + user.getCompleteName() + "\n\n"
		                + "El enlace para recuperar su contraseña es: \n\n"
		                + url + "\n\n"
		                + "Este enlace será válido por 24 horas. Favor no contestar este mensaje";
			emailServiceImpl.sendEmail(user.getEmail(), "no-reply", "Reset password Sistema Solicitudes",mensaje);
			genericResponse = new GenericResponse("success", user.getCompleteName() + ", por favor revise su correo / please check your email, " + user.getEmail());
			
		}
		return createJsonResponse(genericResponse);
	}
	
	@RequestMapping(value = "/processToken", method = RequestMethod.GET)
	public String showChangePasswordPage(Model model, @RequestParam("id") String id, @RequestParam("token") String token, RedirectAttributes redirectAttributes) {
	    String result = usuarioService.validatePasswordResetToken(id, token);
	    if (result != null) {
	    	redirectAttributes.addFlashAttribute("errorResetPassword", true);
    		redirectAttributes.addFlashAttribute("errorMensaje", result);
	        return "redirect:/login";
	    }
	    return "redirect:/users/resetpass";
	}
    
    @RequestMapping(value="/loginfailed", method = RequestMethod.GET)
	public String loginerror(ModelMap model) {
    	model.addAttribute("error", "true");
		return "login";
	}
    
    @RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
		return "login";
	}
	
	@RequestMapping(value="/403", method = RequestMethod.GET)
	public String noAcceso() {
		return "403"; 
	}
	
	@RequestMapping(value="/404", method = RequestMethod.GET)
	public String noEncontrado() { 
		return "404";
	}
    
	@RequestMapping( value="keepsession")
	public @ResponseBody String keepSession()
	{	
		return "OK";
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
