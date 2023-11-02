<%@page import="es.jacaranda.model.User"%>
<%@page import="es.jacaranda.model.CompanyProject"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
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
	if(request.getParameter("closeSession")!=null){
		session.invalidate();
		response.sendRedirect("login.jsp");
		return;
				
	}
	if(session.getAttribute("user")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}

User user = DbRepository.find(User.class,(String)session.getAttribute("user"));
ArrayList<Company> result = null;
	try{
		
		result =(ArrayList<Company>) DbRepository.findAll(Company.class);
		ArrayList resultAux = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
		
	}catch(Exception e){
		
	}
%>
<%
	for (Company c : result){
%>
<form action="" method="post">
	<button name="closeSession" type="submit">Cerrar session</button>
</form>
<table border="1px">

	<tr>
		<td>
		 <b>Nombre Compañia</b>	
		</td>
		<td>
			<b>Num Empleados</b>
		</td>
		<td>
			<b>Num proyectos</b>
		</td>
	</tr>
	<tr>
		<td>
			<%=c.getName() %>
		</td>
		<td>
			<%=c.getEmployee().size() %>
		</td>
		<td>
			<%=c.getCompanyProject().size() %>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<b>Empleados</b>
		</td>
	</tr>
	
		<%
		for (Employee e : c.getEmployee()){
		%>
		<tr >
		<%
			if(user.getRole().equals("ADMIN")){
		%>
		<td colspan="1">
			Empleado: <%=e.getFirstName()%> <%=e.getLastName() %>
		</td>
		<td>
			<a href="updateEmployee.jsp?idEmployee=<%=e.getId()%>"><button type="button">Editar</button></a>
		</td>
		<td>
			<a href="deleteEmployee.jsp?idEmployee=<%=e.getId()%>"><button type="button">Eliminar</button></a>
		</td>
		<%
			}else{
		%>
		<td colspan="3">
			Empleado: <%=e.getFirstName()%> <%=e.getLastName() %>
		</td>
		<%
			}
		%>
		</tr>
		<%
		}
		%>
	
	<tr>
		<td colspan="3">
			<b>Proyectos</b>
		</td>
	</tr>
	<%
				for(CompanyProject compP: c.getCompanyProject()){
			%>
	<tr>
		<td colspan="3">
			
			<%= compP.getProject().getName() %>
		</td>
	</tr>
	<%} %>
</table>
	<%
	}
	%>

</body>
</html>