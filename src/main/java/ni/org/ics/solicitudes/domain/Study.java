package ni.org.ics.solicitudes.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import ni.org.ics.solicitudes.domain.audit.Auditable;


/**
 * Simple objeto de dominio que representa un Estudio
 * 
 * 
 * @author William Aviles
 **/

@Entity
@Table(name = "estudios", catalog = "solicitudes")
public class Study extends BaseMetaData implements Auditable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idEstudio;
	private String codEstudio;
	private String nombreEstudio;
	
	@Id
	@Column(name = "ESTUDIO", nullable = false, length =50)
	public String getIdEstudio() {
		return idEstudio;
	}
	public void setIdEstudio(String idEstudio) {
		this.idEstudio = idEstudio;
	}
	
	@Column(name = "COD_ESTUDIO", nullable = false, length = 10)
	public String getCodEstudio() {
		return codEstudio;
	}
	public void setCodEstudio(String codEstudio) {
		this.codEstudio = codEstudio;
	}
	@Column(name = "NOMBRE_ESTUDIO", nullable = false, length =150)
	public String getNombreEstudio() {
		return nombreEstudio;
	}
	public void setNombreEstudio(String nombreEstudio) {
		this.nombreEstudio = nombreEstudio;
	}
	@Override
	public String toString(){
		return nombreEstudio;
	}
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Study))
			return false;
		
		Study castOther = (Study) other;

		return (this.getIdEstudio().equals(castOther.getIdEstudio()));
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {
		//Campos auditables en la tabla		
		return true;
	}

}

