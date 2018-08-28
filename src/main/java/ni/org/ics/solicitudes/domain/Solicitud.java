package ni.org.ics.solicitudes.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.ForeignKey;

import ni.org.ics.solicitudes.domain.audit.Auditable;
import ni.org.ics.solicitudes.users.model.UserSistema;


@Entity
@Table(name = "solicitudes", catalog = "solicitudes", uniqueConstraints = {
		@UniqueConstraint(columnNames = "NUM_SOLICITUD")})
public class Solicitud extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idSolicitud;
	private Integer numSolicitud;
	private Date fecSolicitud = new Date();
	private Date fecRequerida;
	private Date fecAtendida;
	private Center ctrSolicitud;
	private String estSolicitud;
	private String tipoSolicitud;
	private String motivoCancelada;
	private UserSistema usrSolicitud;
	private String observaciones;
	
	
	@Id
	@Column(name = "ID_SOLICITUD", nullable = false, length =50)
	public String getIdSolicitud() {
		return idSolicitud;
	}
	public void setIdSolicitud(String idSolicitud) {
		this.idSolicitud = idSolicitud;
	}
	
	@Column(name = "NUM_SOLICITUD", nullable = false)
	public Integer getNumSolicitud() {
		return numSolicitud;
	}
	public void setNumSolicitud(Integer numSolicitud) {
		this.numSolicitud = numSolicitud;
	}
	
	@Column(name = "FECHA_SOLICITUD", nullable = false)
	public Date getFecSolicitud() {
		return fecSolicitud;
	}
	public void setFecSolicitud(Date fecSolicitud) {
		this.fecSolicitud = fecSolicitud;
	}
	
	
	@Column(name = "FECHA_REQUERIDA", nullable = true)
	public Date getFecRequerida() {
		return fecRequerida;
	}
	public void setFecRequerida(Date fecRequerida) {
		this.fecRequerida = fecRequerida;
	}
	
	@Column(name = "FECHA_ATENDIDA", nullable = true)
	public Date getFecAtendida() {
		return fecAtendida;
	}
	public void setFecAtendida(Date fecAtendida) {
		this.fecAtendida = fecAtendida;
	}
	@ManyToOne(optional=false)
	@JoinColumn(name="CENTRO_SOL")
	@ForeignKey(name = "SOLICITUDES_CENTROS_FK")
	public Center getCtrSolicitud() {
		return ctrSolicitud;
	}
	public void setCtrSolicitud(Center ctrSolicitud) {
		this.ctrSolicitud = ctrSolicitud;
	}
	
	@Column(name = "ESTADO_SOLICITUD", nullable = false, length =50)
	public String getEstSolicitud() {
		return estSolicitud;
	}
	public void setEstSolicitud(String estSolicitud) {
		this.estSolicitud = estSolicitud;
	}
	
	@Column(name = "TIPO_SOLICITUD", nullable = false, length =50)
	public String getTipoSolicitud() {
		return tipoSolicitud;
	}
	public void setTipoSolicitud(String tipoSolicitud) {
		this.tipoSolicitud = tipoSolicitud;
	}
	
	@Column(name = "OBSERVACIONES", nullable = true, length =500)
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	
	@Column(name = "MOTIVO_CANCELADO", nullable = true, length =200)
	public String getMotivoCancelada() {
		return motivoCancelada;
	}
	public void setMotivoCancelada(String motivoCancelada) {
		this.motivoCancelada = motivoCancelada;
	}
	@Override
	public String toString(){
		return numSolicitud.toString();
	}
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Solicitud))
			return false;
		
		Solicitud castOther = (Solicitud) other;

		return (this.getIdSolicitud().equals(castOther.getIdSolicitud()));
	}
	
	@ManyToOne(optional=false)
	@JoinColumn(name="USUARIO_SOLICITUD")
	@ForeignKey(name = "SOLICITUDES_USUARIOS_FK")
	public UserSistema getUsrSolicitud() {
		return usrSolicitud;
	}
	public void setUsrSolicitud(UserSistema usrSolicitud) {
		this.usrSolicitud = usrSolicitud;
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {
		return true;
	}
	
}
