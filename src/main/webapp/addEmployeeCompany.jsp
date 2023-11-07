<%@page import="es.jacaranda.model.EmployeeProject"%>
<%@page import="java.util.Date"%>

<%@page import="es.jacaranda.repository.DbRepository"%>
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
	if(request.getParameter("End")!=null) {
		int startTime = (int) session.getAttribute("startTime");
		int timeEnd = (int)(new Date().getTime()/1000);
		int totalTime = timeEnd - startTime;
		Project project = (Project) session.getAttribute("project");
		EmployeeProject employeeProject = new EmployeeProject(employee, project, totalTime);
		EmployeeProject ep= DbRepository.find(employeeProject );
		if(ep!=null){
			ep.setMinutes(totalTime);
			DbRepository.update(ep);
		}else{
			
			DbRepository.add(employeeProject);
			
		}
		
		response.sendRedirect("listCompany.jsp");
		return; 
	}else if(request.getParameter("go")!=null){
		int idCompany= Integer.parseInt(request.getParameter("project"));
		Project project = DbRepository.find(Project.class, idCompany);
		session.setAttribute("project", project);
		
		//Iniciamos el tiempo
		//new Date es la fecha actual
		//getTime obtenemos los milisegundos desde 1970 hasta ahora
		// /1000 lo pasamos a minutos
		// int lo convertimos a entero
		int startTime = (int)(new Date().getTime()/1000);
		session.setAttribute("startTime", startTime);
	%>
	<form action="" method="post">
	<div class="d-grid gap-2">
		<button class="btn btn-primary" name="End" type="submit">Parar tiempo</button>
		</div>
	</form>
	
	<%}else if (request.getParameter("showWorks") != null) {
	%>
	<form action="" method="post">
	<select name="project" class="form-select" aria-label="select example"
		>
		<option selected>Projectos</option>
		<% for(CompanyProject cP : employee.getCompany().getCompanyProject()){ 
			Date fechaActual = new Date();
			if(cP.getEnd().after(fechaActual)){
		%>
		<option value="<%=cP.getProject().getId()%>"><%=cP.getProject().getName() %></option>
		<%}} %>
		
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