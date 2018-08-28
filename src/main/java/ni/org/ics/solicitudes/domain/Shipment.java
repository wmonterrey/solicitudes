package ni.org.ics.solicitudes.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;

import ni.org.ics.solicitudes.domain.audit.Auditable;
import ni.org.ics.solicitudes.users.model.UserSistema;

@Entity
@Table(name = "envios", catalog = "solicitudes")
public class Shipment extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idEnvio;
	private Purchase compra;
	private UserSistema usrRecibeEnvio;
	private Date fechaEnvio;
	private String formaEnvio;
	private String observaciones;
	
	@Id
	@Column(name = "ID_ENVIO", nullable = false, length =50)
	public String getIdEnvio() {
		return idEnvio;
	}


	public void setIdEnvio(String idEnvio) {
		this.idEnvio = idEnvio;
	}
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_COMPRA")
	@ForeignKey(name = "SHIPMENT_COMPRAS_FK")
	public Purchase getCompra() {
		return compra;
	}

	public void setCompra(Purchase compra) {
		this.compra = compra;
	}
	
	@ManyToOne(optional=false)
	@JoinColumn(name="USUARIO_SHIPMENT")
	@ForeignKey(name = "SHIPMENT_USUARIOS_FK")
	public UserSistema getUsrRecibeEnvio() {
		return usrRecibeEnvio;
	}


	public void setUsrRecibeEnvio(UserSistema usrRecibeEnvio) {
		this.usrRecibeEnvio = usrRecibeEnvio;
	}


	@Column(name = "FECHA", nullable = false)
	public Date getFechaEnvio() {
		return fechaEnvio;
	}


	public void setFechaEnvio(Date fechaEnvio) {
		this.fechaEnvio = fechaEnvio;
	}
	
	
	@Column(name = "FORMA_ENVIO", nullable = false)
	public String getFormaEnvio() {
		return formaEnvio;
	}


	public void setFormaEnvio(String formaEnvio) {
		this.formaEnvio = formaEnvio;
	}

	
	@Column(name = "OBSERVACIONES", nullable = false)
	public String getObservaciones() {
		return observaciones;
	}


	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}


	@Override
	public boolean isFieldAuditable(String fieldname) {
		return true;
	}
	
}
