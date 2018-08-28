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


@Entity
@Table(name = "items", catalog = "solicitudes")
public class Item extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idItem;
	private Solicitud solicitud;
	private String usrSolicitaItem;
	private Center ctrCompra;
	private String estudio;
	private Insumo insumo;
	private Integer cantSolicitada;
	private String presentacion;
	private Float contenidoPresentacion;
	private Float totalProducto;
	private String autorizado;
	private Integer cantAutorizada;
	private String usrAutorizaItem;
	private Date fechaAutorizado;
	private String aprobado;
	private Integer cantAprobada;
	private String usrApruebaItem;
	private Date fechaAprobado;
	private String estItem;
	private String motivono;
	private String observaciones;
	

	@Id
	@Column(name = "ID_ITEM", nullable = false, length =50)
	public String getIdItem() {
		return idItem;
	}


	public void setIdItem(String idItem) {
		this.idItem = idItem;
	}
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_SOLICITUD")
	@ForeignKey(name = "ITEMS_SOLICITUD_FK")
	public Solicitud getSolicitud() {
		return solicitud;
	}


	public void setSolicitud(Solicitud solicitud) {
		this.solicitud = solicitud;
	}
	
	@Column(name = "USUARIO_SOL", nullable = false, length =50)
	public String getUsrSolicitaItem() {
		return usrSolicitaItem;
	}


	public void setUsrSolicitaItem(String usrSolicitaItem) {
		this.usrSolicitaItem = usrSolicitaItem;
	}
	
	
	@Column(name = "USUARIO_AUT", nullable = true, length =50)
	public String getUsrAutorizaItem() {
		return usrAutorizaItem;
	}


	public void setUsrAutorizaItem(String usrAutorizaItem) {
		this.usrAutorizaItem = usrAutorizaItem;
	}

	@Column(name = "USUARIO_APR", nullable = true, length =50)
	public String getUsrApruebaItem() {
		return usrApruebaItem;
	}


	public void setUsrApruebaItem(String usrApruebaItem) {
		this.usrApruebaItem = usrApruebaItem;
	}


	@ManyToOne(optional=false)
	@JoinColumn(name="CENTRO_COMP")
	@ForeignKey(name = "SOLICITUDES_CENTROS2_FK")
	public Center getCtrCompra() {
		return ctrCompra;
	}
	public void setCtrCompra(Center ctrCompra) {
		this.ctrCompra = ctrCompra;
	}

	@Column(name = "ESTUDIOS", nullable = false, length =255)
	public String getEstudio() {
		return estudio;
	}
	
	public void setEstudio(String estudio) {
		this.estudio = estudio;
	}
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_INSUMO")
	@ForeignKey(name = "ITEMS_INSUMO_FK")
	public Insumo getInsumo() {
		return insumo;
	}


	public void setInsumo(Insumo insumo) {
		this.insumo = insumo;
	}

	@Column(name = "CANTIDAD_SOLICITADA", nullable = false)
	public Integer getCantSolicitada() {
		return cantSolicitada;
	}


	public void setCantSolicitada(Integer cantSolicitada) {
		this.cantSolicitada = cantSolicitada;
	}
	
	@Column(name = "PRESENTACION", nullable = false, length =255)
	public String getPresentacion() {
		return presentacion;
	}
	public void setPresentacion(String presentacion) {
		this.presentacion = presentacion;
	}
	
	@Column(name = "CONT_PRESENTACION", nullable = false)
	public Float getContenidoPresentacion() {
		return contenidoPresentacion;
	}


	public void setContenidoPresentacion(Float contenidoPresentacion) {
		this.contenidoPresentacion = contenidoPresentacion;
	}


	@Column(name = "TOTAL_PRODUCTO", nullable = false)
	public Float getTotalProducto() {
		return totalProducto;
	}


	public void setTotalProducto(Float totalProducto) {
		this.totalProducto = totalProducto;
	}


	@Column(name = "AUTORIZADO", nullable = false, length=50)
	public String getAutorizado() {
		return autorizado;
	}


	public void setAutorizado(String autorizado) {
		this.autorizado = autorizado;
	}

	@Column(name = "CANTIDAD_AUTORIZADA", nullable = true)
	public Integer getCantAutorizada() {
		return cantAutorizada;
	}


	public void setCantAutorizada(Integer cantAutorizada) {
		this.cantAutorizada = cantAutorizada;
	}	


	@Column(name = "APROBADO", nullable = false, length=50)
	public String getAprobado() {
		return aprobado;
	}


	public void setAprobado(String aprobado) {
		this.aprobado = aprobado;
	}


	@Column(name = "CANTIDAD_APROBADA", nullable = true)
	public Integer getCantAprobada() {
		return cantAprobada;
	}


	public void setCantAprobada(Integer cantAprobada) {
		this.cantAprobada = cantAprobada;
	}

	@Column(name = "OBSERVACIONES", nullable = true, length=500)
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	
	
	@Column(name = "FECHA_AUTORIZADO", nullable = true)
	public Date getFechaAutorizado() {
		return fechaAutorizado;
	}


	public void setFechaAutorizado(Date fechaAutorizado) {
		this.fechaAutorizado = fechaAutorizado;
	}

	@Column(name = "FECHA_APROBADO", nullable = true)
	public Date getFechaAprobado() {
		return fechaAprobado;
	}


	public void setFechaAprobado(Date fechaAprobado) {
		this.fechaAprobado = fechaAprobado;
	}

	@Column(name = "ESTADO_ITEM", nullable = false, length =50)
	public String getEstItem() {
		return estItem;
	}


	public void setEstItem(String estItem) {
		this.estItem = estItem;
	}
	
	

	@Column(name = "MOTIVO_CANCELADO", nullable = true, length =150)
	public String getMotivono() {
		return motivono;
	}


	public void setMotivono(String motivono) {
		this.motivono = motivono;
	}


	@Override
	public String toString(){
		return solicitud.getNumSolicitud() +"-"+  insumo.getCodigoBrand();
	}
	
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Item))
			return false;
		
		Item castOther = (Item) other;

		return (this.getIdItem().equals(castOther.getIdItem()));
	}

	@Override
	public boolean isFieldAuditable(String fieldname) {
		return true;
	}
	
}
