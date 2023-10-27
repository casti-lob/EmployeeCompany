package es.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;

import es.jacaranda.utility.DbUtility;
import jakarta.transaction.Transaction;

public class DbRepository {

	public static <E> E find(Class <E>c, int id) throws Exception {
		Transaction transaction = null;
		Session session;
		E result=null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <E>List<E>  findAll(Class <E>c) throws Exception {
		Transaction transaction = null;
		Session session = null;
		List<E> result=null;
		
		try {
			session = DbUtility.getSessionFactory().openSession();
			
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = (List<E>) session.createSelectionQuery("From " + c.getName()).getResultList();
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
}
