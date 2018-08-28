package ni.org.ics.solicitudes.domain.relationship;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



import org.hibernate.annotations.ForeignKey;

import ni.org.ics.solicitudes.domain.BaseMetaData;
import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.audit.Auditable;
import ni.org.ics.solicitudes.users.model.UserSistema;

/**
 * Simple objeto de dominio que representa un centro para un usuario
 * 
 * @author William Aviles
 **/

@Entity
@Table(name = "usuarios_centros", catalog = "solicitudes")
public class UserCenter extends BaseMetaData implements Auditable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserCenterId userCenterId;
	private UserSistema user;
	private Center centro;
	
	public UserCenter() {
	}
	
	public UserCenter(UserCenterId userCenterId, UserSistema user, Center centro
			, String recordUser, Date recordDate) {
		super(recordDate, recordUser);
		this.userCenterId = userCenterId;
		this.user = user;
		this.centro = centro;
	}
	
	@Id
	public UserCenterId getUserCenterId() {
		return userCenterId;
	}
	public void setUserCenterId(UserCenterId userCenterId) {
		this.userCenterId = userCenterId;
	}
	
	@ManyToOne
	@JoinColumn(name="NOMBRE_USUARIO", insertable = false, updatable = false)
	@ForeignKey(name = "UC_USUARIOS_FK")
	public UserSistema getUser() {
		return user;
	}
	
	public void setUser(UserSistema user) {
		this.user = user;
	}
	@ManyToOne
	@JoinColumn(name="CENTRO", insertable = false, updatable = false)
	@ForeignKey(name = "UC_CENTROS_FK")
	public Center getCentro() {
		return centro;
	}
	public void setCentro(Center centro) {
		this.centro = centro;
	}
	
	@Override
	public String toString(){
		return user.getUsername();
	}
	@Override
	public boolean isFieldAuditable(String fieldname) {	
		return true;
	}

}
