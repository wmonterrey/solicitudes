package ni.org.ics.solicitudes.service;

import java.sql.Timestamp;
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
	
	
	@SuppressWarnings("unchecked")
	public List<Purchase> getComprasFiltro(String numFactura, Long desde, Long hasta, String lugarCompra, String proveedor, String cuenta, String insumo, String usuarioactual) {
		
		//Set the SQL Query initially
		String sqlQuery = "from Purchase com where com.lugarCompra in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')";
		// if not null set time parameters
		if(!(desde==null)) {
			sqlQuery = sqlQuery + " and com.fechaCompra between :fechaInicio and :fechaFinal";
		}
		if (!(numFactura==null)) {
			sqlQuery = sqlQuery + " and com.numFactura =:numFactura";
		}
		if(!lugarCompra.equals("ALL")) {
			sqlQuery = sqlQuery + " and com.lugarCompra=:lugarCompra";
		}
		if(!proveedor.equals("ALL")) {
			sqlQuery = sqlQuery + " and com.proveedor=:proveedor";
		}
		if(!cuenta.equals("ALL")) {
			sqlQuery = sqlQuery + " and com.cuenta.idCuenta=:cuenta";
		}
		if(!insumo.equals("ALL")) {
			sqlQuery = sqlQuery + " and com.item.idInsumo=:insumo";
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
		if (!(numFactura==null)) {
			query.setParameter("numFactura", numFactura);
		}
		if(!lugarCompra.equals("ALL")) {
			query.setParameter("lugarCompra", lugarCompra);
		}
		if(!proveedor.equals("ALL")) {
			query.setParameter("proveedor", proveedor);
		}
		if(!cuenta.equals("ALL")) {
			query.setParameter("cuenta", cuenta);
		}
		if(!insumo.equals("ALL")) {
			query.setParameter("insumo", insumo);
		}
		
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
	
	/**
	 * Regresa un Purchase
	 * 
	 * @return un <code>Purchase</code>
	 */

	public Purchase getPurchase(String idCompra, String username) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Purchase p where " +
				"p.idCompra =:idCompra and p.lugarCompra in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:username)");
		query.setParameter("idCompra",idCompra);
		query.setParameter("username", username);
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
	
	@SuppressWarnings("unchecked")
	public List<String> getPresentaciones() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select cmp.presentacion FROM Purchase cmp group by cmp.presentacion order by cmp.presentacion");
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
