package ni.org.ics.solicitudes.web.controller;

import java.text.ParseException;
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

import ni.org.ics.solicitudes.domain.Insumo;
import ni.org.ics.solicitudes.domain.audit.AuditTrail;
import ni.org.ics.solicitudes.language.MessageResource;
import ni.org.ics.solicitudes.service.AuditTrailService;
import ni.org.ics.solicitudes.service.InsumosService;
import ni.org.ics.solicitudes.service.MessageResourceService;

@Controller
@RequestMapping("/super/insumos/*")
public class InsumosController {
	private static final Logger logger = LoggerFactory.getLogger(InsumosController.class);
	
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	@Resource(name="insumosService")
	private InsumosService insumosService;
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String obtenerInsumos(Model model) throws ParseException { 	
    	logger.debug("Mostrando Pagina de busqueda de insumos en JSP");
    	List<MessageResource> tipos = messageResourceService.getCatalogo("CAT_TIPO_INSUMO");
    	model.addAttribute("tipos", tipos);
    	return "insumos/search";
	}
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody List<Insumo> fetchInsumos(@RequestParam(value = "paramFiltrar", required = false, defaultValue = "") String paramFiltrar,
    		@RequestParam(value = "tipoInsumo", required = true) String tipoInsumo
    		) throws ParseException {
        logger.info("Obteniendo insumos");
        List<Insumo> datos = insumosService.getInsumos(paramFiltrar,tipoInsumo);
        if (datos == null){
        	logger.debug("Nulo");
        }
        else {
        	for (Insumo insumo:datos) {
        		MessageResource mr = null;
        		String descCatalogo = null;
        		mr = this.messageResourceService.getMensaje(insumo.getTipoInsumo(),"CAT_TIPO_INSUMO");
        		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		insumo.setTipoInsumo(descCatalogo);
        		mr = this.messageResourceService.getMensaje(insumo.getUndMedida(),"CAT_UND_MED");
        		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
        		insumo.setUndMedida(descCatalogo);
        	}
        }
        return datos;
    }
	
    @RequestMapping("/{idInsumo}/")
    public ModelAndView showInsumo(@PathVariable("idInsumo") String idInsumo) {
    	ModelAndView mav;
    	Insumo insumo = this.insumosService.getInsumo(idInsumo);
        if(insumo==null){
        	mav = new ModelAndView("403");
        }
        else{
        	mav = new ModelAndView("insumos/viewForm");
        	MessageResource mr = null;
    		String descCatalogo = null;
    		mr = this.messageResourceService.getMensaje(insumo.getTipoInsumo(),"CAT_TIPO_INSUMO");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		insumo.setTipoInsumo(descCatalogo);
    		mr = this.messageResourceService.getMensaje(insumo.getUndMedida(),"CAT_UND_MED");
    		descCatalogo = (LocaleContextHolder.getLocale().getLanguage().equals("en")) ? mr.getEnglish(): mr.getSpanish();
    		insumo.setUndMedida(descCatalogo);
        	mav.addObject("insumo",insumo);
            List<AuditTrail> bitacora = auditTrailService.getBitacora(idInsumo);
            mav.addObject("bitacora",bitacora);
        }
        return mav;
    }
	
    @RequestMapping(value = "/addInsumo/", method = RequestMethod.GET)
	public String initAddInsumoForm(Model model) {
    	logger.debug("Agregar insumo");
    	List<MessageResource> tipos = messageResourceService.getCatalogo("CAT_TIPO_INSUMO");
    	model.addAttribute("tipos", tipos);
    	List<MessageResource> unidades = messageResourceService.getCatalogo("CAT_UND_MED");
    	model.addAttribute("unidades", unidades);
    	List<String> marcas = insumosService.getMarcas();
    	model.addAttribute("marcas", marcas);
    	List<String> casas = insumosService.getCasas();
    	model.addAttribute("casas", casas);
    	List<String> categorias = insumosService.getCategorias();
    	model.addAttribute("categorias", categorias);
    	Insumo insumo = new Insumo();
    	model.addAttribute("insumo", insumo);
		return "insumos/enterForm";
	}
    
    @RequestMapping(value = "/editInsumo/{idInsumo}/", method = RequestMethod.GET)
	public String initUpdateInsumoForm(@PathVariable("idInsumo") String idInsumo, Model model) {
    	Insumo insumo = this.insumosService.getInsumo(idInsumo);
		if(insumo!=null){
			model.addAttribute("insumo",insumo);
			List<MessageResource> tipos = messageResourceService.getCatalogo("CAT_TIPO_INSUMO");
	    	model.addAttribute("tipos", tipos);
	    	List<MessageResource> unidades = messageResourceService.getCatalogo("CAT_UND_MED");
	    	model.addAttribute("unidades", unidades);
	    	List<String> marcas = insumosService.getMarcas();
	    	model.addAttribute("marcas", marcas);
	    	List<String> casas = insumosService.getCasas();
	    	model.addAttribute("casas", casas);
	    	List<String> categorias = insumosService.getCategorias();
	    	model.addAttribute("categorias", categorias);
			return "insumos/enterForm";
		}
		else{
			return "403";
		}
	}
    
    @RequestMapping( value="/saveInsumo/", method=RequestMethod.POST)
	public ResponseEntity<String> processUpdateInsumoForm( @RequestParam(value="idInsumo", required=false, defaultValue="" ) String idInsumo
	        , @RequestParam( value="nombreInsumoEn", required=true ) String nombreInsumoEn
	        , @RequestParam( value="nombreInsumoEs", required=true ) String nombreInsumoEs
	        , @RequestParam(value="codigoBrand", required=true) String codigoBrand
	        , @RequestParam(value="casaBrand", required=true) String casaBrand
	        , @RequestParam(value="codigoDistribuidor", required=false) String codigoDistribuidor
	        , @RequestParam(value="casaDistribuidor", required=false) String casaDistribuidor
	        , @RequestParam( value="codigoLocal", required=true ) String codigoLocal
	        , @RequestParam( value="tipoInsumo", required=true) String tipoInsumo
	        , @RequestParam( value="undMedida", required=true) String undMedida
	        , @RequestParam( value="nivelAdvertencia", required=false) Integer nivelAdvertencia
	        )
	{
    	try{
			Insumo insumo = new Insumo();
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			//Si el idInsumo viene en blanco es un nuevo insumo
			if (idInsumo.equals("")){
				//Crear un nuevo insumo
				idInsumo = new UUID(authentication.getName().hashCode(),new Date().hashCode()).toString();
				insumo.setIdInsumo(idInsumo);
				insumo.setRecordUser(authentication.getName());
				insumo.setRecordDate(new Date());
			}
			//Si el idInsumo no viene en blanco hay que editar el insumo
			else{
				//Recupera el insumo de la base de datos
				insumo = this.insumosService.getInsumo(idInsumo);
			}
			insumo.setNombreInsumoEn(nombreInsumoEn);
			insumo.setNombreInsumoEs(nombreInsumoEs);
			insumo.setCodigoBrand(codigoBrand);
			insumo.setCasaBrand(casaBrand);
			if (!codigoDistribuidor.matches("")) insumo.setCodigoDistribuidor(codigoDistribuidor);
			if (!casaDistribuidor.matches("")) insumo.setCasaDistribuidor(casaDistribuidor);
			insumo.setCodigoLocal(codigoLocal);
			insumo.setTipoInsumo(tipoInsumo);
			insumo.setUndMedida(undMedida);
			insumo.setNivelAdvertencia(nivelAdvertencia);
			WebAuthenticationDetails wad  = (WebAuthenticationDetails) authentication.getDetails();
			insumo.setDeviceid(wad.getRemoteAddress());
			//Actualiza el insumo
			this.insumosService.saveInsumo(insumo);
			return createJsonResponse(insumo);
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
    
    
    @RequestMapping("/desInsumo/{idInsumo}/")
    public String disableInsumo(@PathVariable("idInsumo") String idInsumo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	Insumo insumo = this.insumosService.getInsumo(idInsumo);
    	if(insumo!=null){
    		insumo.setPasive('1');
    		this.insumosService.saveInsumo(insumo);
    		redirectAttributes.addFlashAttribute("insumoDeshabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreInsumo", insumo.getCodigoBrand());
    		redirecTo = "redirect:/super/insumos/" + insumo.getIdInsumo() + "/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    @RequestMapping("/habInsumo/{idInsumo}/")
    public String enableInsumo(@PathVariable("idInsumo") String idInsumo, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
    	Insumo insumo = this.insumosService.getInsumo(idInsumo);
    	if(insumo!=null){
    		insumo.setPasive('0');
    		this.insumosService.saveInsumo(insumo);
    		redirectAttributes.addFlashAttribute("insumoHabilitado", true);
    		redirectAttributes.addFlashAttribute("nombreInsumo", insumo.getCodigoBrand());
    		redirecTo = "redirect:/super/insumos/" + insumo.getIdInsumo() + "/";
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
