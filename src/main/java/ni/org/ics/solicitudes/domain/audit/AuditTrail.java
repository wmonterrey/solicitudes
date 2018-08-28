package ni.org.ics.solicitudes.domain.audit;

import java.util.Date;

/**
 * AuditTrail es la clase que representa el registro de auditor�a en el sistema.
 * 
 * AuditTrail incluye informaci�n como:
 * 
 * <ul>
 * <li>Clase
 * <li>Propiedad
 * <li>Valor anterior
 * <li>Valor actual
 * <li>Tipo de operaci�n
 * <li>Usuario
 * <li>Fecha de operaci�n
 * </ul>
 * <p>
 * 
 * 
 *  
 * @author      William Avil�s
 * @version     1.0
 * @since       1.0
 */

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "bitacora", catalog = "solicitudes")
public class AuditTrail {
	
	private int id;
	private String entityId;
	private String entityClass;
	private String entityName;
	private String entityProperty;
	private String entityPropertyOldValue;
	private String entityPropertyNewValue;
	private String operationType;
	private String username;
	private Date operationDate;
	
	
	
	public AuditTrail() {
		super();
	}

	public AuditTrail(String entityId, String entityClass, String entityName,
			String entityProperty, String entityPropertyOldValue,
			String entityPropertyNewValue, String operationType,
			String username, Date operationDate) {
		super();
		this.entityId = entityId;
		this.entityClass = entityClass;
		this.entityName = entityName;
		this.entityProperty = entityProperty;
		this.entityPropertyOldValue = entityPropertyOldValue;
		this.entityPropertyNewValue = entityPropertyNewValue;
		this.operationType = operationType;
		this.username = username;
		this.operationDate = operationDate;
	}
	
	@Id
	@GenericGenerator(name="idautoinc3" , strategy="increment")
	@GeneratedValue(generator="idautoinc3")
	@Column(name="id")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name = "ID_ENTIDAD", nullable = true, length =50)
	public String getEntityId() {
		return entityId;
	}
	public void setEntityId(String entityId) {
		this.entityId = entityId;
	}
	@Column(name = "CLASE_ENTIDAD", nullable = true, length =200)
	public String getEntityClass() {
		return entityClass;
	}

	public void setEntityClass(String entityClass) {
		this.entityClass = entityClass;
	}
	@Column(name = "NOMBRE_ENTIDAD", nullable = true, length =200)
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	@Column(name = "PROPIEDAD", nullable = true, length =150)
	public String getEntityProperty() {
		return entityProperty;
	}
	public void setEntityProperty(String entityProperty) {
		this.entityProperty = entityProperty;
	}
	@Column(name = "VALOR_ANTERIOR", nullable = true, length =1000)
	public String getEntityPropertyOldValue() {
		return entityPropertyOldValue;
	}
	public void setEntityPropertyOldValue(String entityPropertyOldValue) {
		this.entityPropertyOldValue = entityPropertyOldValue;
	}
	@Column(name = "NUEVO_VALOR", nullable = true, length =1000)
	public String getEntityPropertyNewValue() {
		return entityPropertyNewValue;
	}
	public void setEntityPropertyNewValue(String entityPropertyNewValue) {
		this.entityPropertyNewValue = entityPropertyNewValue;
	}
	@Column(name = "TIPO_OPERACION", nullable = true, length =50)
	public String getOperationType() {
		return operationType;
	}
	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	@Column(name = "NOMBRE_USUARIO", nullable = true, length =50)
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	@Column(name = "FECHA_OPERACION", nullable = true)
	public Date getOperationDate() {
		return operationDate;
	}
	public void setOperationDate(Date operationDate) {
		this.operationDate = operationDate;
	}

}
