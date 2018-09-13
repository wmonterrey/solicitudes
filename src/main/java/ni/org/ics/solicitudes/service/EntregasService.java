package ni.org.ics.solicitudes.service;

import java.sql.Timestamp;
import java.util.List;

import javax.annotation.Resource;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ni.org.ics.solicitudes.domain.Deliver;

/**
 * Servicio para el objeto Deliver
 * 
 * @author William Aviles
 * 
 **/

@Service("entregasService")
@Transactional
public class EntregasService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Deliver> getEntregas() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Deliver");
		return query.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Deliver> getEntregasPendienteUsuario(String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Deliver deliver where deliver.entregado = '0' and "
				+ "deliver.itemSolicitado.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and deliver.pasive='0' ");
		query.setParameter("usuarioactual", username);
		return query.list();
	}
	
	/**
	 * Regresa una lista de entregas de un item especifico
	 * 
	 * @return un <code>Deliver</code>
	 */
	@SuppressWarnings("unchecked")
	public List<Deliver> getEntregasThisItem(String idItem) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Deliver deliver where deliver.entregado = '1' and deliver.pasive='0' and deliver.itemSolicitado.idItem=:idItem");
		query.setParameter("idItem", idItem);
		return query.list();
	}
	
	/**
	 * Regresa un Deliver
	 * 
	 * @return un <code>Deliver</code>
	 */

	public Deliver getDeliver(String idEntrega) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Deliver d where " +
				"d.idEntrega =:idEntrega");
		query.setParameter("idEntrega",idEntrega);
		Deliver entrega = (Deliver) query.uniqueResult();
		return entrega;
	}
	
	/**
	 * Regresa un Deliver
	 * 
	 * @return un <code>Deliver</code>
	 */

	public Deliver getDeliver(String idEntrega, String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Deliver d where " +
				"d.idEntrega =:idEntrega and d.itemSolicitado.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and d.pasive='0'");
		query.setParameter("idEntrega",idEntrega);
		query.setParameter("usuarioactual",username);
		Deliver entrega = (Deliver) query.uniqueResult();
		return entrega;
	}

	
	/**
	 * Guarda un Deliver
	 * 
	 * 
	 */
	public void saveDeliver(Deliver deliver) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(deliver);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Deliver> getEntregasFiltro(String numRecibo, Long desde, Long hasta, String usuarioEntrega, String entregado, String verificado, String insumo, String usuarioactual) {
		
		//Set the SQL Query initially
		String sqlQuery = "from Deliver ent where ent.itemSolicitado.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')";
		// if not null set time parameters
		if(!(desde==null)) {
			sqlQuery = sqlQuery + " and ent.fechaEntrega between :fechaInicio and :fechaFinal";
		}
		if (!(numRecibo==null)) {
			sqlQuery = sqlQuery + " and ent.numRecibo =:numRecibo";
		}
		if(!usuarioEntrega.equals("ALL")) {
			sqlQuery = sqlQuery + " and ent.usrRecibeItem.username=:usuarioEntrega";
		}
		if(!entregado.equals("ALL")) {
			sqlQuery = sqlQuery + " and ent.entregado=:entregado";
		}
		if(!verificado.equals("ALL")) {
			sqlQuery = sqlQuery + " and ent.verificado=:verificado";
		}
		if(!insumo.equals("ALL")) {
			sqlQuery = sqlQuery + " and ent.itemSolicitado.insumo.idInsumo=:insumo";
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
		if (!(numRecibo==null)) {
			query.setParameter("numRecibo", numRecibo);
		}
		if(!usuarioEntrega.equals("ALL")) {
			query.setParameter("usuarioEntrega", usuarioEntrega);
		}
		if(!entregado.equals("ALL")) {
			query.setParameter("entregado", entregado);
		}
		if(!verificado.equals("ALL")) {
			query.setParameter("verificado", verificado);
		}
		if(!insumo.equals("ALL")) {
			query.setParameter("insumo", insumo);
		}
		
		return query.list();
	}
	
}
