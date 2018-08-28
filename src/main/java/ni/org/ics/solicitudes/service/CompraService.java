package ni.org.ics.solicitudes.service;

import java.util.List;

import javax.annotation.Resource;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ni.org.ics.solicitudes.domain.Purchase;

/**
 * Servicio para el objeto Purchase
 * 
 * @author William Aviles
 * 
 **/

@Service("compraService")
@Transactional
public class CompraService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Purchase> getCompras() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Purchase");
		return query.list();
	}
	
	/**
	 * Regresa un Purchase
	 * 
	 * @return un <code>Purchase</code>
	 */

	public Purchase getPurchase(String idCompra) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Purchase p where " +
				"p.idCompra =:idCompra");
		query.setParameter("idCompra",idCompra);
		Purchase compra = (Purchase) query.uniqueResult();
		return compra;
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getProveedores() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select cmp.proveedor FROM Purchase cmp group by cmp.proveedor order by cmp.proveedor");
		return query.list();
	}
	
	/**
	 * Guarda un Purchase
	 * 
	 * 
	 */
	public void savePurchase(Purchase purchase) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(purchase);
	}
	
}
