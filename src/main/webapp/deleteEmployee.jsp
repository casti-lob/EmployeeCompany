<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
if(session.getAttribute("user")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}
	
	if(request.getParameter("add")!=null){
		
		int idEmployee=-1;
		
		try{
		idEmployee = Integer.parseInt(request.getParameter("idUpdateEmployee"));
		
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=El id esta mal");
			return;
		}
		
		
		Employee e = null;
		try{
			e = DbRepository.find(Employee.class, idEmployee);
		}catch(Exception ext){
			response.sendRedirect("error.jsp?msg=El empleado no existe");
			return;
		}
		DbRepository.delete(e);
		
		response.sendRedirect("listCompany.jsp");
		
	}else{
		
		Employee e=null;
		try{
		int idEmployee = Integer.parseInt(request.getParameter("idEmployee"));
		e = DbRepository.find(Employee.class, idEmployee);
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=El empleado que quieres actualizar no se encuentra");
			return;
		}
		
		
			
	%>
	<form method="post">
			<p>
				<label>Id</label>
				<input readonly="readonly" value="<%=e.getId()%>" name="idUpdateEmployee" type="text">
			</p>
			
			<p>
				<label>Nombre</label>
				<input readonly="readonly" value="<%=e.getFirstName()%>" name="firstName" type="text">
			</p>
			
			
			<p>
				<label>Apellido</label>
				<input readonly="readonly" value="<%=e.getLastName()%>" name="lastName" type="text">
			</p>
			
			<p>
				<label>Email</label>
				<input readonly="readonly" value="<%=e.getEmail()%>" name="email" type="email">
			</p>
			
			<p>
			<label>Sexo</label>
			<select name="gender">
				<%if(e.getGender().equals("Male")){ %>
				<option value="Male">Hombre</option>
				
				<%}else{ %>
				
				<option value="Male">Hombre</option>
				<%} %>
			</select>
			</p>
			
			<p>
				<label>Fecha nacimiento</label>
				<input readonly="readonly" value="<%=e.getDateOfBirth() %>" name="date" type="date">
			</p>
			
			<p>
			<label>Compañia</label>
			<select name="company">
			
			
			<option selected="selected" value="<%=e.getCompany().getName() %>"><%=e.getCompany().getName() %></option>
			
			
			</select>
			</p>
			
			<button name="add" type="submit">Eliminar</button>
		</form>
	<%} %>
	
</body>
</html>