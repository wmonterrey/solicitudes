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
@Table(name = "entregas", catalog = "solicitudes")
public class Deliver extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idEntrega;
	private Item itemSolicitado;
	private UserSistema usrRecibeItem;
	private String entregado="0";
	private Date fechaEntrega;
	private String numRecibo;
	private String idCompra;
	private Integer cantEntregada;
	private String presentacion;
	private Float contenidoPresentacion;
	private Float totalProducto;
	private String observaciones;
	private String verificado="0";
	private Date fechaVerificacion;
	private String motivoCancelada;
	
	@Id
	@Column(name = "ID_ENTREGA", nullable = false, length =50)
	public String getIdEntrega() {
		return idEntrega;
	}


	public void setIdEntrega(String idEntrega) {
		this.idEntrega = idEntrega;
	}
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_ITEM")
	@ForeignKey(name = "ENTREGAS_ITEMS_FK")
	public Item getItemSolicitado() {
		return itemSolicitado;
	}

	public void setItemSolicitado(Item itemSolicitado) {
		this.itemSolicitado = itemSolicitado;
	}
	
	@ManyToOne(optional=true)
	@JoinColumn(name="USUARIO_DELIVER")
	@ForeignKey(name = "DELIVER_USUARIOS_FK")
	public UserSistema getUsrRecibeItem() {
		return usrRecibeItem;
	}


	public void setUsrRecibeItem(UserSistema usrRecibeItem) {
		this.usrRecibeItem = usrRecibeItem;
	}


	@Column(name = "FECHA", nullable = true)
	public Date getFechaEntrega() {
		return fechaEntrega;
	}


	public void setFechaEntrega(Date fechaEntrega) {
		this.fechaEntrega = fechaEntrega;
	}

	@Column(name = "NUMERO_RECIBO", nullable = true, length =50)
	public String getNumRecibo() {
		return numRecibo;
	}


	public void setNumRecibo(String numRecibo) {
		this.numRecibo = numRecibo;
	}


	@Column(name = "CANTIDAD_ENTREGADA", nullable = false)
	public Integer getCantEntregada() {
		return cantEntregada;
	}

	public void setCantEntregada(Integer cantEntregada) {
		this.cantEntregada = cantEntregada;
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
	
	@Column(name = "OBSERVACIONES", nullable = true, length =755)
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	
	@Column(name = "VERIF", nullable = false, length =1)
	public String getVerificado() {
		return verificado;
	}


	public void setVerificado(String verificado) {
		this.verificado = verificado;
	}
	
	

	@Column(name = "ENT", nullable = false, length =1)
	public String getEntregado() {
		return entregado;
	}


	public void setEntregado(String entregado) {
		this.entregado = entregado;
	}


	@Column(name = "FECHA_VERIF", nullable = true)
	public Date getFechaVerificacion() {
		return fechaVerificacion;
	}


	public void setFechaVerificacion(Date fechaVerificacion) {
		this.fechaVerificacion = fechaVerificacion;
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
		return this.getItemSolicitado().getSolicitud().getNumSolicitud() +"-"+  this.getItemSolicitado().getInsumo().getCodigoBrand();
	}
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Purchase))
			return false;
		
		Deliver castOther = (Deliver) other;

		return (this.getIdEntrega().equals(castOther.getIdEntrega()));
	}


	@Override
	public boolean isFieldAuditable(String fieldname) {
		return true;
	}

	@Column(name = "ID_COMPRA", nullable = true, length =50)
	public String getIdCompra() {
		return idCompra;
	}


	public void setIdCompra(String idCompra) {
		this.idCompra = idCompra;
	}
	
}
