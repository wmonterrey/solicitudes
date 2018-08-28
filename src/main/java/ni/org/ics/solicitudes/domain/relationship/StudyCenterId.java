package ni.org.ics.solicitudes.domain.relationship;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class StudyCenterId implements Serializable {
	/**
	 * Objeto que representa la clave unica de relacion estudio/centro
	 * 
	 * @author William Aviles
	 **/
	
	private static final long serialVersionUID = 1L;
	private String estudio;
	private String centro;
	
	public StudyCenterId(){
		
	}
	
	

	public StudyCenterId(String estudio, String centro) {
		super();
		this.estudio = estudio;
		this.centro = centro;
	}



	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof StudyCenterId))
			return false;
		StudyCenterId castOther = (StudyCenterId) other;

		return this.getEstudio().equals(castOther.getEstudio())
				&& this.getCentro().equals(castOther.getCentro());
	}

	public int hashCode() {
		int result = 17;
		result = 37 * 3 * this.estudio.hashCode() * this.centro.hashCode();
		return result;	
	}
	
	@Column(name = "ESTUDIO", nullable = false, length =50)
	public String getEstudio() {
		return estudio;
	}


	public void setEstudio(String estudio) {
		this.estudio = estudio;
	}

	@Column(name = "CENTRO", nullable = false, length =50)
	public String getCentro() {
		return centro;
	}


	public void setCentro(String centro) {
		this.centro = centro;
	}

	@Override
	public String toString(){
		return centro;
	}

}