<%@page import="java.sql.Date"%>
<%@page import="es.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	if(request.getParameter("add")!=null){
		String name =null;
		int idEmployee=-1;
		String lastName=null;
		String email= null;
		String gender= null;
		try{
		idEmployee = Integer.parseInt(request.getParameter("idUpdateEmployee"));
		name = request.getParameter("firstName");
		lastName = request.getParameter("lastName");
		email = request.getParameter("email");
		gender = request.getParameter("gender");
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=Hay algun parametro en blanco");
			return;
		}
		Date date =null;
		try{
		 date = Date.valueOf( request.getParameter("date"));
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=El empleado que quieres actualizar no se encuentra");
			return;
		}
		int idCompany = Integer.parseInt(request.getParameter("company"));
		Company c = DbRepository.find(Company.class, idCompany);
		Employee e = new Employee(idEmployee, name,lastName,email,gender,date,c);
		DbRepository.add(Employee.class, e);
		
		response.sendRedirect("listCompany.jsp");
		
	}else{
		ArrayList<Company> company = null;
		Employee e=null;
		try{
		int idEmployee = Integer.parseInt(request.getParameter("idEmployee"));
		e = DbRepository.find(Employee.class, idEmployee);
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=El empleado que quieres actualizar no se encuentra");
			return;
		}
		company =(ArrayList<Company>) DbRepository.findAll(Company.class);
		
			
	%>
	<form method="post">
			<p>
				<label>Id</label>
				<input readonly="readonly" value="<%=e.getId()%>" name="idUpdateEmployee" type="text">
			</p>
			
			<p>
				<label>Nombre</label>
				<input value="<%=e.getFirstName()%>" name="firstName" type="text">
			</p>
			
			
			<p>
				<label>Apellido</label>
				<input value="<%=e.getLastName()%>" name="lastName" type="text">
			</p>
			
			<p>
				<label>Email</label>
				<input value="<%=e.getEmail()%>" name="email" type="email">
			</p>
			
			<p>
			<label>Sexo</label>
			<select name="gender">
				<%if(e.getGender().equals("Male")){ %>
				<option value="Male">Hombre</option>
				<option value="Female">Mujer</option>
				<%}else{ %>
				<option value="Female">Mujer</option>
				<option value="Male">Hombre</option>
				<%} %>
			</select>
			</p>
			
			<p>
				<label>Fecha nacimiento</label>
				<input value="<%=e.getDateOfBirth() %>" name="date" type="date">
			</p>
			
			<p>
			<label>Compañia</label>
			<select name="company">
			
			<%
				for(Company c : company){
					if(e.getCompany().getId()==c.getId()){
			%>
			<option selected="selected" value="<%=c.getId()%>"><%=c.getName() %></option>
			<%
				}else{
			%>
			<option  value="<%=c.getId()%>"><%=c.getName() %></option>
			<%}} %>
			</select>
			</p>
			
			<button name="add" type="submit">Añadir</button>
		</form>
	<%} %>
	
</body>
</html>