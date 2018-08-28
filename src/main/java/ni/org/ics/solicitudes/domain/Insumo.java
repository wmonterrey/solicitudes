package ni.org.ics.solicitudes.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import ni.org.ics.solicitudes.domain.audit.Auditable;



/**
 * Simple objeto de dominio que representa un insumo
 * 
 * 
 * @author William Aviles
 **/

@Entity
@Table(name = "insumos", catalog = "solicitudes", uniqueConstraints = {
		@UniqueConstraint(columnNames = {"MODELO","MARCA"}),
		@UniqueConstraint(columnNames = {"COD_DISTRIBUIDOR","DISTRIBUIDOR"})})
public class Insumo extends BaseMetaData implements Auditable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idInsumo;
	private String nombreInsumoEn;
	private String nombreInsumoEs;
	private String codigoBrand;
	private String casaBrand;
	private String codigoDistribuidor;
	private String casaDistribuidor;
	private String codigoLocal;
	private String tipoInsumo;
	private String undMedida;
	private Integer nivelAdvertencia;
	
	
	
	@Id
	@Column(name = "INSUMO", nullable = false, length =50)
	public String getIdInsumo() {
		return idInsumo;
	}
	public void setIdInsumo(String idInsumo) {
		this.idInsumo = idInsumo;
	}
	@Column(name = "NOMBRE_INSUMO_EN", nullable = false, length =250)
	public String getNombreInsumoEn() {
		return nombreInsumoEn;
	}
	public void setNombreInsumoEn(String nombreInsumoEn) {
		this.nombreInsumoEn = nombreInsumoEn;
	}
	@Column(name = "NOMBRE_INSUMO_ES", nullable = false, length =250)
	public String getNombreInsumoEs() {
		return nombreInsumoEs;
	}
	public void setNombreInsumoEs(String nombreInsumoEs) {
		this.nombreInsumoEs = nombreInsumoEs;
	}	
	
	
	@Column(name = "MODELO", nullable = false, length =100)
	public String getCodigoBrand() {
		return codigoBrand;
	}
	public void setCodigoBrand(String codigoBrand) {
		this.codigoBrand = codigoBrand;
	}
	
	@Column(name = "MARCA", nullable = false, length =250)
	public String getCasaBrand() {
		return casaBrand;
	}
	public void setCasaBrand(String casaBrand) {
		this.casaBrand = casaBrand;
	}
	
	@Column(name = "COD_DISTRIBUIDOR", nullable = true, length =100)
	public String getCodigoDistribuidor() {
		return codigoDistribuidor;
	}
	public void setCodigoDistribuidor(String codigoDistribuidor) {
		this.codigoDistribuidor = codigoDistribuidor;
	}
	
	@Column(name = "DISTRIBUIDOR", nullable = true, length =250)
	public String getCasaDistribuidor() {
		return casaDistribuidor;
	}
	public void setCasaDistribuidor(String casaDistribuidor) {
		this.casaDistribuidor = casaDistribuidor;
	}
	
	@Column(name = "COD_LOCAL", nullable = false, length =100)
	public String getCodigoLocal() {
		return codigoLocal;
	}
	public void setCodigoLocal(String codigoLocal) {
		this.codigoLocal = codigoLocal;
	}
	
	@Column(name = "TIPO_INSUMO", nullable = false, length =50)
	public String getTipoInsumo() {
		return tipoInsumo;
	}
	public void setTipoInsumo(String tipoInsumo) {
		this.tipoInsumo = tipoInsumo;
	}
	
	@Column(name = "UNIDAD_MEDIDA", nullable = false, length =50)
	public String getUndMedida() {
		return undMedida;
	}


	public void setUndMedida(String undMedida) {
		this.undMedida = undMedida;
	}
	
	
	@Column(name = "NIVEL_ADVERTENCIA", nullable = true)
	public Integer getNivelAdvertencia() {
		return nivelAdvertencia;
	}
	public void setNivelAdvertencia(Integer nivelAdvertencia) {
		this.nivelAdvertencia = nivelAdvertencia;
	}
	@Override
	public String toString(){
		return codigoBrand;
	}
	
	@Override
	public boolean equals(Object other) {
		
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Insumo))
			return false;
		
		Insumo castOther = (Insumo) other;

		return (this.getIdInsumo().equals(castOther.getIdInsumo()));
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {
		//Campos auditables en la tabla
		return true;
	}

}

