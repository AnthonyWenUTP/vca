package org.clintonhealthaccess.vca.web.controller;

import org.clintonhealthaccess.vca.domain.Distrito;
import org.clintonhealthaccess.vca.domain.Localidad;
import org.clintonhealthaccess.vca.domain.audit.AuditTrail;
import org.clintonhealthaccess.vca.service.DistritoService;
import org.clintonhealthaccess.vca.service.LocalidadService;
import org.clintonhealthaccess.vca.service.AuditTrailService;
import org.clintonhealthaccess.vca.service.MessageResourceService;
import org.clintonhealthaccess.vca.service.ParametroService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
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
 * Controlador web de peticiones
 * 
 * @author William Aviles
 */
@Controller
@RequestMapping("/admin/localities/*")
public class AdminLocalidadesController {
	private static final Logger logger = LoggerFactory.getLogger(AdminLocalidadesController.class);
	@Resource(name="localidadService")
	private LocalidadService localidadService;
	@Resource(name="distritoService")
	private DistritoService distritoService;
	@Resource(name="auditTrailService")
	private AuditTrailService auditTrailService;
	@Resource(name="messageResourceService")
	private MessageResourceService messageResourceService;
	
	@Resource(name="parametroService")
	private ParametroService parametroService;
    
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String getEntities(Model model) throws ParseException { 	
    	logger.debug("Mostrando Localidads en JSP");
    	List<Localidad> localidades = localidadService.getLocalities();
    	model.addAttribute("localidades", localidades);
    	return "admin/localidades/list";
	}
	
	/**
     * Custom handler for adding.
     * @param model Modelo enlazado a la vista
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/newEntity/", method = RequestMethod.GET)
	public String addEntity(Model model) {
    	List <Distrito> distritos = this.distritoService.getActiveDistricts();
    	model.addAttribute("distritos", distritos);
    	return "admin/localidades/enterForm";
	}
    
    /**
     * Custom handler for displaying.
     *
     * @param ident the ID to display
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping("/{ident}/")
    public ModelAndView showEntity(@PathVariable("ident") String ident) {
    	ModelAndView mav;
    	Localidad localidad = this.localidadService.getLocal(ident);
    	Float latitud;
    	Float longitud;
    	Integer zoom;
        if(localidad==null){
        	mav = new ModelAndView("403");
        }
        else{
        	try {
	        	mav = new ModelAndView("admin/localidades/viewForm");
	        	mav.addObject("localidad",localidad);
	        	zoom = Integer.parseInt(parametroService.getParametroByCode("zoom").getValue());
	        	latitud = Float.parseFloat(parametroService.getParametroByCode("lat").getValue());
	        	longitud = Float.parseFloat(parametroService.getParametroByCode("long").getValue());
	        	if(localidad.getLatitude()!=null) latitud = localidad.getLatitude();
	        	if(localidad.getLongitude()!=null) longitud = localidad.getLongitude();
	        	if(localidad.getZoom()!=null) zoom = localidad.getZoom();
	        	mav.addObject("latitude",latitud);
	        	mav.addObject("longitude",longitud);
	        	mav.addObject("zoom",zoom);
	        	List<AuditTrail> bitacora = auditTrailService.getBitacora(ident);
	            mav.addObject("bitacora",bitacora);
        	}
        	catch (Exception e) {
        		mav = new ModelAndView("505");
        		mav.addObject("errormsg",e.getLocalizedMessage());
        	}
        }
        return mav;
    }
    
    /**
     * Custom handler for editing.
     * @param model Modelo enlazado a la vista
     * @param ident the ID to edit
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/editEntity/{ident}/", method = RequestMethod.GET)
	public String editEntity(@PathVariable("ident") String ident, Model model) {
		Localidad localidad = this.localidadService.getLocal(ident);
		if(localidad!=null){
			List <Distrito> distritos = this.distritoService.getActiveDistricts();
	    	model.addAttribute("distritos", distritos);
			model.addAttribute("localidad",localidad);
			return "admin/localidades/enterForm";
		}
		else{
			return "403";
		}
	}
    
    /**
     * Custom handler for editing.
     * @param model Modelo enlazado a la vista
     * @param ident the ID to edit
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping(value = "/enterLocation/{ident}/", method = RequestMethod.GET)
	public String enterLocation(@PathVariable("ident") String ident, Model model) {
		Localidad localidad = this.localidadService.getLocal(ident);
		if(localidad!=null){
			try {
				model.addAttribute("localidad",localidad);
				Float latitud;
		    	Float longitud;
		    	Integer zoom;
		    	zoom = Integer.parseInt(parametroService.getParametroByCode("zoom").getValue());
	        	latitud = Float.parseFloat(parametroService.getParametroByCode("lat").getValue());
	        	longitud = Float.parseFloat(parametroService.getParametroByCode("long").getValue());
	        	if(localidad.getLatitude()!=null) latitud = localidad.getLatitude();
	        	if(localidad.getLongitude()!=null) longitud = localidad.getLongitude();
	        	if(localidad.getZoom()!=null) zoom = localidad.getZoom();
	        	model.addAttribute("latitude",latitud);
	        	model.addAttribute("longitude",longitud);
	        	model.addAttribute("zoom",zoom);
				return "admin/localidades/enterLocation";
			}
        	catch (Exception e) {
        		model.addAttribute("errormsg",e.getLocalizedMessage());
        		return "505";
        	}
		}
		else{
			return "403";
		}
	}
	
    /**
     * Custom handler for saving.
     * 
     * @param ident Identificador unico
     * @param code codigo
     * @param name nombre
     * @return a ModelMap with the model attributes for the view
     */
    @RequestMapping( value="/saveEntity/", method=RequestMethod.POST)
	public ResponseEntity<String> processEntity( @RequestParam(value="ident", required=false, defaultValue="" ) String ident
	        , @RequestParam( value="code", required=true ) String code
	        , @RequestParam( value="name", required=true ) String name
	        , @RequestParam( value="district", required=true) String district
	        , @RequestParam( value="latitude", required=false, defaultValue ="" ) String latitude
	        , @RequestParam( value="longitude", required=false, defaultValue ="" ) String longitude
	        , @RequestParam( value="zoom", required=false, defaultValue ="" ) String zoom
	        , @RequestParam( value="population", required=false, defaultValue ="" ) String population
	        , @RequestParam( value="obs", required=false, defaultValue ="" ) String obs
	        )
	{
    	try{
    		Float latitud = null;
    		Float longitud = null;
    		Integer vista= null;
    		Integer poblacion= null;
    		
    		if(!latitude.equals("")) latitud = Float.valueOf(latitude);
    		if(!longitude.equals("")) longitud = Float.valueOf(longitude);
    		if(!zoom.equals("")) vista = Integer.valueOf(zoom);
    		if(!population.equals("")) poblacion = Integer.valueOf(population);
    		
    		Distrito disLoc = this.distritoService.getDistrict(district);
			Localidad localidad = new Localidad();
			//Si el ident viene en blanco es nuevo
			if (ident.equals("")){
				//Crear nuevo
				ident = new UUID(SecurityContextHolder.getContext().getAuthentication().getName().hashCode(),new Date().hashCode()).toString();
				localidad.setIdent(ident);
				localidad.setRecordUser(SecurityContextHolder.getContext().getAuthentication().getName());
				localidad.setRecordDate(new Date());
			}
			//Si el ident no viene en blanco hay que editar
			else{
				//Recupera de la base de datos
				localidad = localidadService.getLocal(ident);
			}
			localidad.setCode(code);
			localidad.setName(name);
			localidad.setDistrict(disLoc);
			localidad.setLatitude(latitud);
			localidad.setLongitude(longitud);
			localidad.setZoom(vista);
			localidad.setPopulation(poblacion);
			localidad.setObs(obs);
			//Actualiza
			this.localidadService.saveLocal(localidad);
			return createJsonResponse(localidad);
    	}
		catch (DataIntegrityViolationException e){
			String message = e.getMostSpecificCause().getMessage();
			Gson gson = new Gson();
		    String json = gson.toJson(message);
		    return createJsonResponse(json);
		}
		catch(Exception e){
			Gson gson = new Gson();
		    String json = gson.toJson(e.toString());
		    return createJsonResponse(json);
		}
    	
	}
    
    /**
     * Custom handler for disabling.
     *
     * @param ident the ID to disable
     * @param redirectAttributes 
     * @return a String
     */
    @RequestMapping("/disableEntity/{ident}/")
    public String disableEntity(@PathVariable("ident") String ident, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		Localidad distrito = this.localidadService.getLocal(ident);
    	if(distrito!=null){
    		distrito.setPasive('1');
    		this.localidadService.saveLocal(distrito);
    		redirectAttributes.addFlashAttribute("entidadDeshabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreEntidad", distrito.getName());
    		redirecTo = "redirect:/admin/localities/"+distrito.getIdent()+"/";
    	}
    	else{
    		redirecTo = "403";
    	}
    	return redirecTo;	
    }
    
    
    /**
     * Custom handler for enabling.
     *
     * @param ident the ID to enable
     * @param redirectAttributes
     * @return a String
     */
    @RequestMapping("/enableEntity/{ident}/")
    public String enableEntity(@PathVariable("ident") String ident, 
    		RedirectAttributes redirectAttributes) {
    	String redirecTo="404";
		Localidad localidad = this.localidadService.getLocal(ident);
    	if(localidad!=null){
    		localidad.setPasive('0');
    		this.localidadService.saveLocal(localidad);
    		redirectAttributes.addFlashAttribute("entidadHabilitada", true);
    		redirectAttributes.addFlashAttribute("nombreEntidad", localidad.getName());
    		redirecTo = "redirect:/admin/localities/"+localidad.getIdent()+"/";
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
    
    
    @RequestMapping(value = "/getMap/", method = RequestMethod.GET)
    public String fetchCohorteJSP(Model model) throws ParseException {
    	logger.debug("Mostrando Mapa en JSP");
    	return "admin/localidades/mapa";
	}  
	
}
