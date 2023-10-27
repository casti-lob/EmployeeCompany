<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="java.util.ArrayList"%>
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
ArrayList<Employee> result = null;
	try{
		
		result =(ArrayList<Employee>) DbRepository.findAll(Employee.class);
		
	}catch(Exception e){
		
	}
%>
<table class="table">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Nombre Personaje</th>
						<th scope="col">Info</th>
					</tr>
				</thead>
				<tbody>
					<%
					

						for (Employee e : result) {
					%>
					<tr>
						<th scope="row"></th> <!-- Acumulamos para indicar el numero de personajes -->
						<td><%=e.getFirstName()%></td>
						<td><!-- Ponemos el valor del button la PK -->
							<button type="submit" class="btn btn-primary"
								name="characterName" value="-">Detalles</button> <!-- Mandamos el id de personajes -->
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
</body>
</html>