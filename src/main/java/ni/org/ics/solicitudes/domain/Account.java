package ni.org.ics.solicitudes.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import ni.org.ics.solicitudes.domain.audit.Auditable;


/**
 * Simple objeto de dominio que representa una Cuenta
 * 
 * 
 * @author William Aviles
 **/

@Entity
@Table(name = "cuentas", catalog = "solicitudes")
public class Account extends BaseMetaData implements Auditable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idCuenta;
	private String nombreCuenta;
	
	@Id
	@Column(name = "CUENTA", nullable = false, length =50)
	public String getIdCuenta() {
		return idCuenta;
	}
	public void setIdCuenta(String idCuenta) {
		this.idCuenta = idCuenta;
	}
	@Column(name = "NOMBRE_CUENTA", nullable = false, length =150)
	public String getNombreCuenta() {
		return nombreCuenta;
	}
	public void setNombreCuenta(String nombreCuenta) {
		this.nombreCuenta = nombreCuenta;
	}
	@Override
	public String toString(){
		return nombreCuenta;
	}
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Account))
			return false;
		
		Account castOther = (Account) other;

		return (this.getIdCuenta().equals(castOther.getIdCuenta()));
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {
		//Campos auditables en la tabla
		return true;
	}

}

