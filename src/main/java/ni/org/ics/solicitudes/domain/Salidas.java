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
@Table(name = "salidas", catalog = "solicitudes")
public class Salidas extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idSalida;
	private Insumo item;
	private Center centro;
	private Date fechasalida;
	private String lote;
	private Integer cantEntregada;
	private String presentacion;
	private Float contenidoPresentacion;
	private Float totalProducto;
	private String usrSalida;
	private String observaciones;
	
	@Id
	@Column(name = "ID_SALIDA", nullable = false, length =50)
	public String getIdSalida() {
		return idSalida;
	}


	public void setIdSalida(String idSalida) {
		this.idSalida = idSalida;
	}
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_ITEM")
	@ForeignKey(name = "SALIDAS_ITEMS_FK")
	public Insumo getItem() {
		return item;
	}

	public void setItem(Insumo item) {
		this.item = item;
	}
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ID_CENTRO")
	@ForeignKey(name = "SALIDAS_CENTRO_FK")
	public Center getCentro() {
		return centro;
	}


	public void setCentro(Center centro) {
		this.centro = centro;
	}
	
	
	@Column(name = "FECHA_SALIDA", nullable = false)
	public Date getFechaSalida() {
		return fechasalida;
	}


	public void setFechaSalida(Date fechasalida) {
		this.fechasalida = fechasalida;
	}

	@Column(name = "LOTE", nullable = true, length =100)
	public String getLote() {
		return lote;
	}


	public void setLote(String lote) {
		this.lote = lote;
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
	
	@Column(name = "USUARIO_SALIDA", nullable = false, length =500)
	public String getUsrSalida() {
		return usrSalida;
	}


	public void setUsrSalida(String usrSalida) {
		this.usrSalida = usrSalida;
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
