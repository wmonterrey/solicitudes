package ni.org.ics.solicitudes.domain;

import java.util.Date;


public class Saldo {
	
	/**
	 * 
	 */	
	
	private Insumo item;
	private Center centro;
	private String lote;
	private Integer saldo;
	private String presentacion;
	private Float contenidoPresentacion;
	private Float totalSaldo;
	private Date fechaExpiracion;
	
	public Insumo getItem() {
		return item;
	}

	public void setItem(Insumo item) {
		this.item = item;
	}
	
	public Center getCentro() {
		return centro;
	}


	public void setCentro(Center centro) {
		this.centro = centro;
	}
	
	
	public Date getFechaExpiracion() {
		return fechaExpiracion;
	}


	public void setFechaExpiracion(Date fechaExpiracion) {
		this.fechaExpiracion = fechaExpiracion;
	}
	
	public String getLote() {
		return lote;
	}


	public void setLote(String lote) {
		this.lote = lote;
	}

	public Integer getSaldo() {
		return saldo;
	}

	public void setSaldo(Integer saldo) {
		this.saldo = saldo;
	}

	public String getPresentacion() {
		return presentacion;
	}

	public void setPresentacion(String presentacion) {
		this.presentacion = presentacion;
	}

	public Float getContenidoPresentacion() {
		return contenidoPresentacion;
	}

	public void setContenidoPresentacion(Float contenidoPresentacion) {
		this.contenidoPresentacion = contenidoPresentacion;
	}

	public Float getTotalSaldo() {
		return totalSaldo;
	}

	public void setTotalSaldo(Float totalSaldo) {
		this.totalSaldo = totalSaldo;
	}
	
	
	
}
