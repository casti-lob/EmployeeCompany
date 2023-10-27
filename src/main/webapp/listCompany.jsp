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
ArrayList<Company> result = null;
	try{
		
		result =(ArrayList<Company>) DbRepository.findAll(Company.class);
		ArrayList resultAux = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
		
	}catch(Exception e){
		
	}
%>
<table class="table">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Nombre Compañia</th>
						<th scope="col">N empleados</th>
						<th scope="col">Nombre empleados</th>
						<th scope="col">Projectos</th>
					</tr>
				</thead>
				<tbody>
					<%
					

						for (Company c : result) {
					%>
					<tr>
						<th scope="row"></th> <!-- Acumulamos para indicar el numero de personajes -->
						<td><%=c.getName()%></td>
						<td><%=c.getEmployee().size()%></td>
						<td>
							<table>
							<thead>
					<tr>
						<th >Nombre EMpleado</th>
						
					</tr>
				</thead>
							<tbody>
							<%
								for (Employee e : c.getEmployee()){
							%>
							<tr>
								<td><%=e.getFirstName() %></td>
							</tr>
							
							
							<%
								}
							%>
							</tbody>
							</table>
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
</body>
</html>