package es.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.jacaranda.model.CompanyProject;
import es.jacaranda.utility.DbUtility;

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
	public static <E> E find(Class <E>c, String id) throws Exception {
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
	
	public static <E> E add(Class <E>c, Object element) throws Exception {
		Transaction transaction = null;
		E result= null;
		Session session = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			 session.merge(element);//persist para companyProject
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
		return (E) result;
		
	}
	
	public static CompanyProject find(CompanyProject cp) throws Exception {
		Session session = null;
		CompanyProject result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result =  session.find(CompanyProject.class, cp);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	
	public static <E> E delete(Class <E>c, Object element) throws Exception {
		Transaction transaction = null;
		E result= null;
		Session session = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			session.remove(element);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
		return  result;
		
	}
}
