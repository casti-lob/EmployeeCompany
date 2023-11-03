<%@page import="es.jacaranda.model.CompanyProject"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@page import="es.jacaranda.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<body>
	<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}
	Employee employee =(Employee) session.getAttribute("user");
	if (request.getParameter("showWorks") != null) {
	%>
	<form action="" method="post">
	<select name="project" class="form-select" aria-label="select example"
		>
		<option selected>Projectos</option>
		<% for(CompanyProject cP : employee.getCompany().getCompanyProject()){ %>
		<option value="<%=cP.getProject().getId()%>"><%=cP.getProject().getName() %></option>
		<%} %>
		
	</select>
	<div class="d-grid gap-2">
		<button class="btn btn-primary" name="go" type="submit">Empezar</button>
		</div>
	</form>
	<%
	} else {
	%>
	<form action="" method="post">
		<div class="d-grid gap-2">
			<button name="showWorks" class="btn btn-primary" type="submit">Asignar
				Tiempo</button>
		</div>
	</form>
	<%
	}
	%>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>