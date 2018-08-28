package ni.org.ics.solicitudes.domain.relationship;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class UserCenterId implements Serializable {
	/**
	 * Objeto que representa la clave unica de relacion usuario/centro
	 * 
	 * @author William Aviles
	 **/
	
	private static final long serialVersionUID = 1L;
	private String username;
	private String center;
	
	public UserCenterId(){
		
	}
	
	

	public UserCenterId(String username, String center) {
		super();
		this.username = username;
		this.center = center;
	}



	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof UserCenterId))
			return false;
		UserCenterId castOther = (UserCenterId) other;

		return this.getUsername().equals(castOther.getUsername())
				&& this.getCenter().equals(castOther.getCenter());
	}

	public int hashCode() {
		int result = 17;
		result = 37 * 3 * this.username.hashCode() * this.center.hashCode();
		return result;	
	}
	
	@Column(name = "NOMBRE_USUARIO", nullable = false, length =50)
	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "CENTRO", nullable = false, length =50)
	public String getCenter() {
		return center;
	}


	public void setCenter(String center) {
		this.center = center;
	}

	@Override
	public String toString(){
		return center;
	}

}