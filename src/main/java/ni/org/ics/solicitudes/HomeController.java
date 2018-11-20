package ni.org.ics.solicitudes;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ni.org.ics.solicitudes.domain.Solicitud;
import ni.org.ics.solicitudes.domain.util.ObjetoReporte;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.EmailServiceImpl;
import ni.org.ics.solicitudes.service.MessageResourceService;
import ni.org.ics.solicitudes.service.SolicitudesService;
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
	@Resource(name="solicitudesService")
	private SolicitudesService solicitudesService;
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model) {
    	try {
	    	logger.info("Solicitudes Iniciado...");
	    	DecimalFormat df2 = new DecimalFormat(".##");
	    	MessageResource mr = null;
    		String descCatalogo = null;
	    	Integer total = 0;
	    	ObjetoReporte totalSolicitudes = new ObjetoReporte();
	    	ObjetoReporte solicitudesNuevas = new ObjetoReporte();
	    	ObjetoReporte solicitudesCompletas = new ObjetoReporte();
	    	ObjetoReporte solicitudesSinAprobar = new ObjetoReporte();
	    	ObjetoReporte solicitudesSinAutorizar = new ObjetoReporte();
	    	ObjetoReporte solicitudesSinRevisar = new ObjetoReporte();
	    	ObjetoReporte solicitudesSinComprar = new ObjetoReporte();
	    	ObjetoReporte solicitudesSinEntregar = new ObjetoReporte();
	    	ObjetoReporte solicitudesEliminadas = new ObjetoReporte();
	    	List<ObjetoReporte> porEstado = new ArrayList<ObjetoReporte>();
	    	List<ObjetoReporte> porCentro = new ArrayList<ObjetoReporte>();
	    	List<ObjetoReporte> porTipo = new ArrayList<ObjetoReporte>();
	    	List<ObjetoReporte> porUsuario = new ArrayList<ObjetoReporte>();
	    	List<ObjetoReporte> iporTipo = new ArrayList<ObjetoReporte>();
	    	List<ObjetoReporte> iporCat = new ArrayList<ObjetoReporte>();
	    	
	    	
	    	UserSistema usuarioActual = this.usuarioService.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
	    	List<Object[]> datosSolEstado = solicitudesService.getSolicitudesporCategoria(usuarioActual.getUsername(),"sol.estSolicitud");
	    	for(Object[] o:datosSolEstado) {
	    		total = total + Integer.valueOf(o[1].toString());
	    		if(o[0].toString().equals("SOLFIN")) {
	    			mr = this.messageResourceService.getMensaje("solicitudesCompletas");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesCompletas.setLabel(descCatalogo);
	    			solicitudesCompletas.setValue(o[1].toString());
	    			porEstado.add(solicitudesCompletas);
	    		}
	    		else if(o[0].toString().equals("PENAPR")){
	    			mr = this.messageResourceService.getMensaje("solicitudesSinAprobar");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesSinAprobar.setLabel(descCatalogo);
	    			solicitudesSinAprobar.setValue(o[1].toString());
	    			porEstado.add(solicitudesSinAprobar);
	    		}
	    		else if(o[0].toString().equals("PENAUT")){
	    			mr = this.messageResourceService.getMensaje("solicitudesSinAutorizar");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesSinAutorizar.setLabel(descCatalogo);
	    			solicitudesSinAutorizar.setValue(o[1].toString());
	    			porEstado.add(solicitudesSinAutorizar);
	    		}
	    		else if(o[0].toString().equals("SOLNUE")){
	    			mr = this.messageResourceService.getMensaje("solicitudesNuevas");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesNuevas.setLabel(descCatalogo);
	    			solicitudesNuevas.setValue(o[1].toString());
	    			porEstado.add(solicitudesNuevas);
	    		}
	    		else if(o[0].toString().equals("PENREV")){
	    			mr = this.messageResourceService.getMensaje("solicitudesSinRevisar");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesSinRevisar.setLabel(descCatalogo);
	    			solicitudesSinRevisar.setValue(o[1].toString());
	    			porEstado.add(solicitudesSinRevisar);
	    		}
	    		else if(o[0].toString().equals("PENCOM")){
	    			mr = this.messageResourceService.getMensaje("solicitudesSinComprar");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesSinComprar.setLabel(descCatalogo);
	    			solicitudesSinComprar.setValue(o[1].toString());
	    			porEstado.add(solicitudesSinComprar);
	    		}
	    		else if(o[0].toString().equals("PENENT")){
	    			mr = this.messageResourceService.getMensaje("solicitudesSinEntregar");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesSinEntregar.setLabel(descCatalogo);
	    			solicitudesSinEntregar.setValue(o[1].toString());
	    			porEstado.add(solicitudesSinEntregar);
	    		}
	    		else if(o[0].toString().equals("SOLELM")){
	    			mr = this.messageResourceService.getMensaje("solicitudesEliminadas");
	    			descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    			solicitudesEliminadas.setLabel(descCatalogo);
	    			solicitudesEliminadas.setValue(o[1].toString());
	    			porEstado.add(solicitudesEliminadas);
	    		}
	    	}
	    	//Todas las solicitudes
	    	totalSolicitudes.setLabel("totalSolicitudes");
	    	totalSolicitudes.setValue(total.toString());
	    	
	    	
	    	List<Object[]> datosSolCentro = solicitudesService.getSolicitudesporCategoria(usuarioActual.getUsername(),"sol.ctrSolicitud.nombreCentro");
	    	for(Object[] o:datosSolCentro) {
	    		porCentro.add(new ObjetoReporte(o[0].toString(),o[1].toString()));
	    	}
	    	
	    	List<Object[]> datosSolTipo = solicitudesService.getSolicitudesporCategoria(usuarioActual.getUsername(),"sol.tipoSolicitud");
	    	for(Object[] o:datosSolTipo) {
	    		descCatalogo="";
	    		mr = this.messageResourceService.getMensaje(o[0].toString(),"CAT_TIPO_SOL");
    			if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    		porTipo.add(new ObjetoReporte(descCatalogo,o[1].toString()));
	    	}
	    	
	    	List<Object[]> datosItemTipo = solicitudesService.getItemsporCategoria(usuarioActual.getUsername(),"it.insumo.tipoInsumo");
	    	for(Object[] o:datosItemTipo) {
	    		descCatalogo="";
	    		mr = this.messageResourceService.getMensaje(o[0].toString(),"CAT_TIPO_INSUMO");
    			if(mr!=null) descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	    		iporTipo.add(new ObjetoReporte(descCatalogo,o[1].toString()));
	    	}
	    	
	    	List<Object[]> datosSolUsuario = solicitudesService.getSolicitudesporCategoria(usuarioActual.getUsername(),"sol.usrSolicitud.username");
	    	for(Object[] o:datosSolUsuario) {
	    		porUsuario.add(new ObjetoReporte(o[0].toString(),o[1].toString()));
	    	}
	    	
	    	List<Object[]> datosItemsCat = solicitudesService.getItemsporCategoria(usuarioActual.getUsername(),"it.insumo.codigoLocal");
	    	for(Object[] o:datosItemsCat) {
	    		iporCat.add(new ObjetoReporte(o[0].toString(),o[1].toString()));
	    	}
	    	
	    	//Agregar al modelo los datos
	    	model.addAttribute("porEstado", porEstado);
	    	model.addAttribute("totalSolicitudes", totalSolicitudes);
	    	model.addAttribute("solicitudesCompletas", solicitudesCompletas);
	    	String porcCompletas = df2.format(Float.valueOf(solicitudesCompletas.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcCompletas", porcCompletas);
	    	model.addAttribute("solicitudesSinAprobar", solicitudesSinAprobar);
	    	String porcNoAprob = df2.format(Float.valueOf(solicitudesSinAprobar.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcNoAprob", porcNoAprob);
	    	model.addAttribute("solicitudesSinAutorizar", solicitudesSinAutorizar);
	    	String porcNoAut = df2.format(Float.valueOf(solicitudesSinAutorizar.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcNoAut", porcNoAut);
	    	model.addAttribute("solicitudesNuevas", solicitudesNuevas);
	    	String porcNuevas = df2.format(Float.valueOf(solicitudesNuevas.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcNuevas", porcNuevas);
	    	model.addAttribute("solicitudesSinRevisar", solicitudesSinRevisar);
	    	String porcARev = df2.format(Float.valueOf(solicitudesSinRevisar.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcARev", porcARev);
	    	model.addAttribute("solicitudesSinComprar", solicitudesSinComprar);
	    	String porcACom = df2.format(Float.valueOf(solicitudesSinComprar.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcACom", porcACom);
	    	model.addAttribute("solicitudesSinEntregar", solicitudesSinEntregar);
	    	String porcAEnt = df2.format(Float.valueOf(solicitudesSinEntregar.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcAEnt", porcAEnt);
	    	model.addAttribute("solicitudesEliminadas", solicitudesEliminadas);
	    	String porcEliminadas = df2.format(Float.valueOf(solicitudesEliminadas.getValue()) / Float.valueOf(totalSolicitudes.getValue()) * 100);
	    	model.addAttribute("porcEliminadas", porcEliminadas);
	    	//Solicitudes por centro
	    	model.addAttribute("porCentro", porCentro);
	    	//Solicitudes por tipo
	    	model.addAttribute("porTipo", porTipo);
	    	//Solicitudes por usuario
	    	model.addAttribute("porUsuario", porUsuario);
	    	//Items por tipo
	    	model.addAttribute("iporTipo", iporTipo);
	    	//Items por categoria
	    	model.addAttribute("iporCat", iporCat);
	    	//Solicitudes atrasadas
	    	List<Solicitud> atrasadas = solicitudesService.getSolicitudesAtrasadas(usuarioActual.getUsername());
	    	if (atrasadas == null){
	        	logger.debug("Nulo");
	        }
	        else {
	        	for (Solicitud solicitud:atrasadas) {
	        		mr = this.messageResourceService.getMensaje(solicitud.getEstSolicitud(),"CAT_EST_SOL");
	        		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	        		solicitud.setEstSolicitud(descCatalogo);
	        		mr = this.messageResourceService.getMensaje(solicitud.getTipoSolicitud(),"CAT_TIPO_SOL");
	        		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
	        		solicitud.setTipoSolicitud(descCatalogo);
	        	}
	        }
	    	model.addAttribute("atrasadas", atrasadas);
	    	
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
