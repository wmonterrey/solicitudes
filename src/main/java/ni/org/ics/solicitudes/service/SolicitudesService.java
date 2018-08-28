package ni.org.ics.solicitudes.service;

import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Resource;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import ni.org.ics.solicitudes.domain.Solicitud;

/**
 * Servicio para el objeto Solicitud
 * 
 * @author William Aviles
 * 
 **/

@Service("solicitudesService")
@Transactional
public class SolicitudesService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Solicitud> getSolicitudes() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Solicitud");
		return query.list();
	}

	/**
	 * Regresa un Solicitud
	 * 
	 * @return un <code>Solicitud</code>
	 */

	public Solicitud getSolicitud(String idSolicitud) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Solicitud s where " +
				"s.idSolicitud =:idSolicitud");
		query.setParameter("idSolicitud",idSolicitud);
		Solicitud solicitud = (Solicitud) query.uniqueResult();
		return solicitud;
	}
	
	
	/**
	 * Regresa un Solicitud
	 * 
	 * @return un <code>Solicitud</code>
	 */

	public Solicitud getSolicitud(String idSolicitud, String usuarioactual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Solicitud s where " +
				"s.idSolicitud =:idSolicitud and s.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')");
		query.setParameter("idSolicitud",idSolicitud);
		query.setParameter("usuarioactual", usuarioactual);
		Solicitud solicitud = (Solicitud) query.uniqueResult();
		return solicitud;
	}
	
	
	/**
	 * Nuevo numero de Solicitud
	 * 
	 * @return un <code>Integer</code>
	 */

	public Integer getNextNumber() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select Max(numSolicitud) FROM Solicitud");
		Integer numSolicitud = (Integer) query.uniqueResult();
		if (numSolicitud==null) {
			numSolicitud = 1;
		}
		else {
			numSolicitud = numSolicitud + 1;
		}
		return numSolicitud;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Solicitud> getSolicitudesFiltro(Integer numSolicitud, 
			Long desde, Long hasta, String ctrSolicitud, String tipoSolicitud, String estSolicitud, String usrSolicitud, String usuarioactual) {
		//Set the SQL Query initially
		String sqlQuery = "from Solicitud sol where sol.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')";
		// if not null set time parameters
		if(!(desde==null)) {
			sqlQuery = sqlQuery + " and sol.fecSolicitud between :fechaInicio and :fechaFinal";
		}
		if (!(numSolicitud==null)) {
			sqlQuery = sqlQuery + " and sol.numSolicitud =:numSolicitud";
		}
		if(!ctrSolicitud.equals("ALL")) {
			sqlQuery = sqlQuery + " and sol.ctrSolicitud.idCentro=:ctrSolicitud";
		}
		if(!tipoSolicitud.equals("ALL")) {
			sqlQuery = sqlQuery + " and sol.tipoSolicitud=:tipoSolicitud";
		}
		if(!estSolicitud.equals("ALL")) {
			sqlQuery = sqlQuery + " and sol.estSolicitud=:estSolicitud";
		}
		if(!usrSolicitud.equals("ALL")) {
			sqlQuery = sqlQuery + " and sol.usrSolicitud.username=:usrSolicitud";
		}
		
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		// Create a Hibernate query (HQL)
		Query query = session.createQuery(sqlQuery);
		if(!(desde==null)) {
			Timestamp timeStampInicio = new Timestamp(desde);
			Timestamp timeStampFinal = new Timestamp(hasta);
			query.setTimestamp("fechaInicio", timeStampInicio);
			query.setTimestamp("fechaFinal", timeStampFinal);
		}
		query.setParameter("usuarioactual", usuarioactual);
		if (!(numSolicitud==null)) {
			query.setParameter("numSolicitud", numSolicitud);
		}
		if(!ctrSolicitud.equals("ALL")) {
			query.setParameter("ctrSolicitud", ctrSolicitud);
		}
		if(!tipoSolicitud.equals("ALL")) {
			query.setParameter("tipoSolicitud", tipoSolicitud);
		}
		if(!estSolicitud.equals("ALL")) {
			query.setParameter("estSolicitud", estSolicitud);
		}
		if(!usrSolicitud.equals("ALL")) {
			query.setParameter("usrSolicitud", usrSolicitud);
		}
		
		// Retrieve all
		return  query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Solicitud> getSolicitudesporEstado(String usuarioactual, String estSolicitud) {
		//Set the SQL Query initially
		String sqlQuery = "from Solicitud sol where sol.estSolicitud=:estSolicitud and sol.pasive = '0' and sol.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')";
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		// Create a Hibernate query (HQL)
		Query query = session.createQuery(sqlQuery);
		query.setParameter("usuarioactual", usuarioactual);
		query.setParameter("estSolicitud", estSolicitud);
		// Retrieve all
		return  query.list();
	}
	
	/**
	 * Guarda un Solicitud
	 * 
	 * 
	 */
	public void saveSolicitud(Solicitud solicitud) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(solicitud);
	}
	
}
