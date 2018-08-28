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
@Table(name = "entradas", catalog = "solicitudes")
public class Entradas extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idEntrada;
	private Insumo item;
	private Center centro;
	private Date fechaEntrada;
	private String lote;
	private String serie;
	private Integer cantRecibida;
	private String presentacion;
	private Float contenidoPresentacion;
	private Float totalProducto;
	private String usrEntrada;
	private Date fechaExpiracion;
	private String observaciones;
	
	@Id
	@Column(name = "ID_ENTRADA", nullable = false, length =50)
	public String getIdEntrada() {
		return idEntrada;
	}


	public void setIdEntrada(String idEntrada) {
		this.idEntrada = idEntrada;
	}
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_ITEM")
	@ForeignKey(name = "ENTRADAS_ITEMS_FK")
	public Insumo getItem() {
		return item;
	}

	public void setItem(Insumo item) {
		this.item = item;
	}
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_CENTRO")
	@ForeignKey(name = "ENTRADAS_CENTRO_FK")
	public Center getCentro() {
		return centro;
	}


	public void setCentro(Center centro) {
		this.centro = centro;
	}
	
	
	@Column(name = "FECHA_ENTRADA", nullable = false)
	public Date getFechaEntrada() {
		return fechaEntrada;
	}


	public void setFechaEntrada(Date fechaEntrada) {
		this.fechaEntrada = fechaEntrada;
	}

	@Column(name = "FECHA_EXPIRACION", nullable = true)
	public Date getFechaExpiracion() {
		return fechaExpiracion;
	}


	public void setFechaExpiracion(Date fechaExpiracion) {
		this.fechaExpiracion = fechaExpiracion;
	}


	@Column(name = "LOTE", nullable = true, length =100)
	public String getLote() {
		return lote;
	}


	public void setLote(String lote) {
		this.lote = lote;
	}


	@Column(name = "SERIE", nullable = true, length =100)
	public String getSerie() {
		return serie;
	}


	public void setSerie(String serie) {
		this.serie = serie;
	}


	@Column(name = "CANTIDAD_RECIBIDA", nullable = false)
	public Integer getCantRecibida() {
		return cantRecibida;
	}

	public void setCantRecibida(Integer cantRecibida) {
		this.cantRecibida = cantRecibida;
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
	
	
	@Column(name = "USUARIO_ENTRADA", nullable = false, length =500)
	public String getUsrEntrada() {
		return usrEntrada;
	}


	public void setUsrEntrada(String usrEntrada) {
		this.usrEntrada = usrEntrada;
	}


	@Column(name = "OBSERVACIONES", nullable = false, length =500)
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
