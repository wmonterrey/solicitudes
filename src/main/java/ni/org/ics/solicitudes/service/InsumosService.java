package ni.org.ics.solicitudes.service;

import java.util.List;

import javax.annotation.Resource;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ni.org.ics.solicitudes.domain.Insumo;

/**
 * Servicio para el objeto Insumo
 * 
 * @author William Aviles
 * 
 **/

@Service("insumosService")
@Transactional
public class InsumosService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Insumo> getInsumos() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Insumo ins");
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Insumo> getInsumosActivos() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Insumo ins where ins.pasive = '0' order by ins.codigoBrand");
		return query.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Insumo> getInsumos(String paramFiltrar, String tipoInsumo) {
		//Set the SQL Query initially
		String sqlQuery = "from Insumo ins where 1=1";
		// if not null set time parameters
		if (!paramFiltrar.matches("")) {
			sqlQuery = sqlQuery + " and (lower(ins.nombreInsumoEn) like:paramFiltrar or lower(ins.nombreInsumoEs) like:paramFiltrar "
					+ "or lower(ins.codigoBrand) like:paramFiltrar or lower(ins.casaBrand) like:paramFiltrar or lower(ins.codigoDistribuidor) like:paramFiltrar or lower(ins.casaDistribuidor) like:paramFiltrar or lower(ins.codigoLocal) like:paramFiltrar)";
		}
		if(!tipoInsumo.equals("ALL")) {
			sqlQuery = sqlQuery + " and ins.tipoInsumo=:tipoInsumo";
		}
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(sqlQuery);
		if (!paramFiltrar.matches("")) {
			query.setParameter("paramFiltrar", "%"+paramFiltrar.toLowerCase()+"%");
		}
		if(!tipoInsumo.equals("ALL")) {
			query.setParameter("tipoInsumo", tipoInsumo);
		}
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getMarcas() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select ins.casaBrand FROM Insumo ins group by ins.casaBrand order by ins.casaBrand");
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getCasas() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select ins.casaDistribuidor FROM Insumo ins group by ins.casaDistribuidor order by ins.casaDistribuidor");
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getCategorias() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select ins.codigoLocal FROM Insumo ins group by ins.codigoLocal order by ins.codigoLocal");
		return query.list();
	}

	/**
	 * Regresa un Insumo
	 * 
	 * @return un <code>Insumo</code>
	 */

	public Insumo getInsumo(String idInsumo) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Insumo ins where " +
				"ins.idInsumo =:idInsumo");
		query.setParameter("idInsumo",idInsumo);
		Insumo insumo = (Insumo) query.uniqueResult();
		return insumo;
	}
	
	/**
	 * Guarda un Insumo
	 * 
	 * 
	 */
	public void saveInsumo(Insumo insumo) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(insumo);
	}
	
}
