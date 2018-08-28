package ni.org.ics.solicitudes.service;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ni.org.ics.solicitudes.domain.Center;
import ni.org.ics.solicitudes.domain.relationship.StudyCenter;
import ni.org.ics.solicitudes.domain.relationship.UserCenter;

/**
 * Servicio para el objeto Center
 * 
 * @author William Aviles
 * 
 **/

@Service("centroService")
@Transactional
public class CentroService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	
	/*Lista de centros, todos los centros*/
	@SuppressWarnings("unchecked")
	public List<Center> getCentros() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center");
		return query.list();
	}
	
	/*Lista de centros, centros activos*/
	@SuppressWarnings("unchecked")
	public List<Center> getCentrosActivos() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center c where c.pasive='0'");
		return query.list();
	}
	
	/*Lista de centros, centros que pueen comprar*/
	@SuppressWarnings("unchecked")
	public List<Center> getCentrosqueCompran() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center c where c.pasive='0' and c.puedeComprar='1'");
		return query.list();
	}
	
	/**
	 * Regresa un Center, por su identificador
	 * 
	 * @return un <code>Center</code>
	 */
	public Center getCentro(String idCentro) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center c where " +
				"c.idCentro =:idCentro");
		query.setParameter("idCentro",idCentro);
		Center centro = (Center) query.uniqueResult();
		return centro;
	}
	
	
	/**
	 * Regresa un Center, por su identificador verificando que pertenece al usuario
	 * 
	 * @return un <code>Center</code>
	 */

	public Center getCentro(String idCentro, String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center c where " +
				"c.idCentro =:idCentro and c.idCentro in "
				+ "(Select uc.centro.idCentro from UserCenter uc where uc.user.username =:username and uc.pasive = '0')");
		query.setParameter("username",username);
		query.setParameter("idCentro",idCentro);
		Center centro = (Center) query.uniqueResult();
		return centro;
	}
	
	
	
	/**
	 * Guarda un center
	 * 
	 * 
	 */
	public void saveCenter(Center center) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(center);
	}
	
	
	/**
	 * Regresa un UserCenter
	 * 
	 * @return un <code>UserCenter</code>
	 */

	public UserCenter getUserCenter(String idCentro, String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM UserCenter uc where " +
				"uc.userCenterId.center =:idCentro and uc.userCenterId.username =:username");
		query.setParameter("idCentro",idCentro);
		query.setParameter("username",username);
		UserCenter usercentro = (UserCenter) query.uniqueResult();
		return usercentro;
	}
	
	/**
	 * Regresa  UserCenter activos de un Center
	 * 
	 * @return una lista de <code>UserCenter</code>
	 */

	@SuppressWarnings("unchecked")
	public List<UserCenter> getUsersCenter(String idCentro) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM UserCenter uc where " +
				"uc.userCenterId.center =:idCentro and uc.pasive ='0'");
		query.setParameter("idCentro",idCentro);
		List<UserCenter> userscentro = query.list();
		return userscentro;
	}
	
	/**
	 * Regresa  todos los UserCenter de un Center
	 * 
	 * @return una lista de <code>UserCenter</code>
	 */

	@SuppressWarnings("unchecked")
	public List<UserCenter> getAllUsersCenter(String idCentro) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM UserCenter uc where " +
				"uc.userCenterId.center =:idCentro");
		query.setParameter("idCentro",idCentro);
		List<UserCenter> userscentro = query.list();
		return userscentro;
	}
	
	/**
	 * Regresa todos los UserCenter de un User
	 * 
	 * @return una lista de <code>UserCenter</code>
	 */

	@SuppressWarnings("unchecked")
	public List<UserCenter> getAllCentersUser(String userName) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM UserCenter uc where " +
				"uc.userCenterId.username =:userName");
		query.setParameter("userName",userName);
		List<UserCenter> userscentro = query.list();
		return userscentro;
	}
	
	
	/**
	 * Guarda un usercenter
	 * 
	 * 
	 */
	public void saveUserCenter(UserCenter usercenter) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(usercenter);
	}
	
	/**
	 * Regresa un StudyCenter
	 * 
	 * @return un <code>StudyCenter</code>
	 */

	public StudyCenter getStudyCenter(String idCentro, String idEstudio) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM StudyCenter sc where " +
				"sc.estudioCentroId.centro =:idCentro and sc.estudioCentroId.estudio =:idEstudio");
		query.setParameter("idCentro",idCentro);
		query.setParameter("idEstudio",idEstudio);
		StudyCenter studycentro = (StudyCenter) query.uniqueResult();
		return studycentro;
	}
	
	/**
	 * Regresa  StudyCenter de un Center
	 * 
	 * @return una lista de <code>StudyCenter</code>
	 */

	@SuppressWarnings("unchecked")
	public List<StudyCenter> getStudyCenter(String idCentro) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM StudyCenter sc where " +
				"sc.estudioCentroId.centro =:idCentro and sc.pasive ='0'");
		query.setParameter("idCentro",idCentro);
		List<StudyCenter> studiescentro = query.list();
		return studiescentro;
	}
	
	/**
	 * Regresa todos los StudyCenter de un Center
	 * 
	 * @return una lista de <code>StudyCenter</code>
	 */

	@SuppressWarnings("unchecked")
	public List<StudyCenter> getAllStudyCenter(String idCentro) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM StudyCenter sc where " +
				"sc.estudioCentroId.centro =:idCentro");
		query.setParameter("idCentro",idCentro);
		List<StudyCenter> studiescentro = query.list();
		return studiescentro;
	}
	
	/**
	 * Guarda un StudyCenter
	 * 
	 * 
	 */
	public void saveStudyCenter(StudyCenter studycenter) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(studycenter);
	}
	
	@SuppressWarnings("unchecked")
	public List<Center> getCentrosDelusuario(String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center cen where cen.idCentro in " +
				"(Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')");
		query.setParameter("usuarioactual",username);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<Center> getCentrosActivosDelusuario(String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center cen where cen.pasive = '0' and cen.idCentro in " +
				"(Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')");
		query.setParameter("usuarioactual",username);
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Center> getCentrosActivosDelusuarioQueCompran(String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center cen where cen.pasive = '0' and cen.puedeComprar='1' and cen.idCentro in " +
				"(Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')");
		query.setParameter("usuarioactual",username);
		return query.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Center> getCentrosActivosNoTieneElUsuario(String username, String userActual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Center cen where cen.pasive = '0' and cen.idCentro in " +
				"(Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and cen.idCentro not in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioeditado)");
		query.setParameter("usuarioactual",userActual);
		query.setParameter("usuarioeditado",username);
		return query.list();
	}
}
