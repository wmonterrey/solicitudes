package ni.org.ics.solicitudes.domain.audit;

/**
 * Auditable es la interface que todas las clases deben implementar para ser parte de la auditor�a en el sistema.
 *  
 * @author      William Avil�s
 * @version     1.0
 * @since       1.0
 */

public interface Auditable {
	
	public boolean isFieldAuditable(String fieldname);

}
