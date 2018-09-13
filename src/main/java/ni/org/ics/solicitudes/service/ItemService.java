package ni.org.ics.solicitudes.service;

import java.util.List;

import javax.annotation.Resource;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ni.org.ics.solicitudes.domain.Item;

/**
 * Servicio para el objeto Item
 * 
 * @author William Aviles
 * 
 **/

@Service("itemService")
@Transactional
public class ItemService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Item> getItems() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item");
		return query.list();
	}

	/**
	 * Regresa un Item
	 * 
	 * @return un <code>Item</code>
	 */

	public Item getItem(String idItem) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item i where " +
				"i.idItem =:idItem");
		query.setParameter("idItem",idItem);
		Item item = (Item) query.uniqueResult();
		return item;
	}
	
	
	/**
	 * Regresa un Item
	 * 
	 * @return un <code>Item</code>
	 */

	public Item getItem(String idItem, String usuarioactual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item item where " +
				"item.idItem =:idItem and item.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0')");
		query.setParameter("idItem",idItem);
		query.setParameter("usuarioactual", usuarioactual);
		Item item = (Item) query.uniqueResult();
		return item;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Item> getItemsFiltro(String idSolicitud, String usuarioactual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item item where " +
				"item.solicitud.idSolicitud =:idSolicitud and item.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and item.pasive='0'");
		query.setParameter("idSolicitud",idSolicitud);
		query.setParameter("usuarioactual", usuarioactual);
		
		// Retrieve all
		return  query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Item> getItemsFiltroNumSolicitud(Integer numSolicitud, String usuarioactual, String estado) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item item where item.estItem <> :estado and " +
				"item.solicitud.numSolicitud =:numSolicitud and item.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and item.pasive='0'");
		query.setParameter("numSolicitud",numSolicitud);
		query.setParameter("usuarioactual", usuarioactual);
		query.setParameter("estado", estado);
		
		// Retrieve all
		return  query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Item> getItemsAprobados(String idSolicitud, String usuarioactual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item item where " +
				"item.solicitud.idSolicitud =:idSolicitud and item.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and item.pasive='0' and "
				+ "(item.aprobado ='APRPA' or item.aprobado ='APROB')");
		query.setParameter("idSolicitud",idSolicitud);
		query.setParameter("usuarioactual", usuarioactual);
		
		// Retrieve all
		return  query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Item> getItemsFiltrados(String filtro, String usuarioactual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item item where " +
				"item.solicitud.ctrSolicitud.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and item.pasive='0' and "
				+ "(item.estItem =:filtro)");
		query.setParameter("filtro",filtro);
		query.setParameter("usuarioactual", usuarioactual);
		
		// Retrieve all
		return  query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Item> getItemsAComprar(String usuarioactual) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Item item where " +
				"item.ctrCompra.idCentro in (Select uc.centro.idCentro from UserCenter uc where uc.user.username =:usuarioactual and uc.pasive = '0') and item.pasive='0' and "
				+ "(item.estItem =:filtro)");
		query.setParameter("filtro","COMPRA");
		query.setParameter("usuarioactual", usuarioactual);
		
		// Retrieve all
		return  query.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<String> getPresentaciones() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("Select it.presentacion FROM Item it group by it.presentacion order by it.presentacion");
		return query.list();
	}
	
	/**
	 * Guarda un Item
	 * 
	 * 
	 */
	public void saveItem(Item item) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(item);
	}
	
}
