package ni.org.ics.solicitudes.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import ni.org.ics.solicitudes.domain.audit.Auditable;



/**
 * Simple objeto de dominio que representa un centro
 * 
 * 
 * @author William Aviles
 **/

@Entity
@Table(name = "centros", catalog = "solicitudes", uniqueConstraints = @UniqueConstraint(columnNames = "NOMBRE_CENTRO"))
public class Center extends BaseMetaData implements Auditable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idCentro;
	private String nombreCentro;
	private String puedeComprar;
	
	@Id
	@Column(name = "CENTRO", nullable = false, length =50)
	public String getIdCentro() {
		return idCentro;
	}
	public void setIdCentro(String idCentro) {
		this.idCentro = idCentro;
	}
	@Column(name = "NOMBRE_CENTRO", nullable = false, length =150)
	public String getNombreCentro() {
		return nombreCentro;
	}
	public void setNombreCentro(String nombreCentro) {
		this.nombreCentro = nombreCentro;
	}
	@Column(name = "PUEDE_COMPRAR", nullable = false, length =5)
	public String getPuedeComprar() {
		return puedeComprar;
	}
	public void setPuedeComprar(String puedeComprar) {
		this.puedeComprar = puedeComprar;
	}
	@Override
	public String toString(){
		return nombreCentro;
	}
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Center))
			return false;
		
		Center castOther = (Center) other;

		return (this.getIdCentro().equals(castOther.getIdCentro()));
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {
		//Campos auditables en la tabla
		return true;
	}

}

