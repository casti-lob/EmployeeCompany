package es.jacaranda.repository;

import org.hibernate.Session;

import es.jacaranda.utility.DbUtility;
import jakarta.transaction.Transaction;

public class DbRepository {

	public static <E> E find() throws Exception {
		Transaction transaction = null;
		Session session;
		E result=null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(E, result);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
}
