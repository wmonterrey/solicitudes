package ni.org.ics.solicitudes.service;

import java.util.List;

import javax.annotation.Resource;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ni.org.ics.solicitudes.domain.Account;

/**
 * Servicio para el objeto Account
 * 
 * @author William Aviles
 * 
 **/

@Service("cuentaService")
@Transactional
public class CuentaService {
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	public List<Account> getCuentas() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Account");
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Account> getActiveCuentas() {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Account s where s.pasive ='0'");
		return query.list();
	}
	
	/**
	 * Regresa un Account
	 * 
	 * @return un <code>Account</code>
	 */

	public Account getAccount(String idCuenta) {
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Account s where " +
				"s.idCuenta =:idCuenta");
		query.setParameter("idCuenta",idCuenta);
		Account cuenta = (Account) query.uniqueResult();
		return cuenta;
	}
	
	/**
	 * Guarda un Account
	 * 
	 * 
	 */
	public void saveAccount(Account account) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(account);
	}
	
}
