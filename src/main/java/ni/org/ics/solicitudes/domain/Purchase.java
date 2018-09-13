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
@Table(name = "compras", catalog = "solicitudes")
public class Purchase extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idCompra;
	private Insumo item;
	private Account cuenta;
	private String lugarCompra;
	private Date fechaCompra;
	private String proveedor;
	private String numFactura;
	private Integer cantComprada;
	private String presentacion;
	private Float contenidoPresentacion;
	private Float totalProducto;
	private String motivoCancelada;
	private String observaciones;
	
	@Id
	@Column(name = "ID_COMPRA", nullable = false, length =50)
	public String getIdCompra() {
		return idCompra;
	}


	public void setIdCompra(String idCompra) {
		this.idCompra = idCompra;
	}
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_ITEM")
	@ForeignKey(name = "COMPRAS_ITEMS_FK")
	public Insumo getItem() {
		return item;
	}

	public void setItem(Insumo item) {
		this.item = item;
	}
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_CUENTA")
	@ForeignKey(name = "COMPRAS_CUENTA_FK")
	public Account getCuenta() {
		return cuenta;
	}


	public void setCuenta(Account cuenta) {
		this.cuenta = cuenta;
	}
	
	@Column(name = "LUGAR", nullable = false, length =150)
	public String getLugarCompra() {
		return lugarCompra;
	}


	public void setLugarCompra(String lugarCompra) {
		this.lugarCompra = lugarCompra;
	}
	
	
	@Column(name = "FECHA", nullable = false)
	public Date getFechaCompra() {
		return fechaCompra;
	}


	public void setFechaCompra(Date fechaCompra) {
		this.fechaCompra = fechaCompra;
	}


	@Column(name = "PROVEEDOR", nullable = false, length =255)
	public String getProveedor() {
		return proveedor;
	}


	public void setProveedor(String proveedor) {
		this.proveedor = proveedor;
	}
	
	
	@Column(name = "NUMERO_FACTURA", nullable = true, length =50)
	public String getNumFactura() {
		return numFactura;
	}


	public void setNumFactura(String numFactura) {
		this.numFactura = numFactura;
	}


	@Column(name = "CANTIDAD_COMPRADA", nullable = true)
	public Integer getCantComprada() {
		return cantComprada;
	}

	public void setCantComprada(Integer cantComprada) {
		this.cantComprada = cantComprada;
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
		return this.getItem().getCodigoBrand() + " - " + this.numFactura + " - " + this.proveedor ;
	}
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Purchase))
			return false;
		
		Purchase castOther = (Purchase) other;

		return (this.getIdCompra().equals(castOther.getIdCompra()));
	}
	
	@Override
	public boolean isFieldAuditable(String fieldname) {
		return true;
	}
	
}
