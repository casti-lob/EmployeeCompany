<%@page import="java.sql.Date"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
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
	String name = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	Date date = Date.valueOf( request.getParameter("date"));
	int idCompany = Integer.parseInt(request.getParameter("company"));
	Company c = DbRepository.find(Company.class, idCompany);
	Employee e = new Employee(name,lastName,email,gender,date,c);
	
	DbRepository.add(Employee.class, e);

			%>
<%
}else{
	ArrayList<Company> result = null;
	try{
		result =(ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception e){
		
	}
	%>
		<form method="post">
			<p>
				<label>Nombre</label>
				<input name="firstName" type="text">
			</p>
			
			
			<p>
				<label>Apellido</label>
				<input name="lastName" type="text">
			</p>
			
			<p>
				<label>Email</label>
				<input name="email" type="email">
			</p>
			
			<p>
			<label>Sexo</label>
			<select name="gender">
				<option value="Male">Hombre</option>
				<option value="Female">Mujer</option>
			</select>
			</p>
			
			<p>
				<label>Fecha nacimiento</label>
				<input name="date" type="date">
			</p>
			
			<p>
			<label>Compañia</label>
			<select name="company">
			<%
				for(Company c : result){
			%>
			<option value="<%=c.getId()%>"><%=c.getName() %></option>
			<%
				}
			%>
			</select>
			</p>
			
			<button name="add" type="submit">Añadir</button>
		</form>
<%} %>


</body>
</html>