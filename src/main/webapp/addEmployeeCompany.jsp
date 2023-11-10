<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashSet"%>
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
	 //Comprobamos el login
	if (session.getAttribute("user") == null) {
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}
	Employee employee = (Employee) session.getAttribute("user");
	HashMap<Integer, Integer> workingProyect = (HashMap<Integer, Integer>) session.getAttribute("workingProyect");
	//Si mandamos el formulario
	if (request.getParameter("start") != null) {
		if (workingProyect != null) {

			//Iniciamos el tiempo
			//new Date es la fecha actual
			//getTime obtenemos los milisegundos desde 1970 hasta ahora
			// /1000 lo pasamos a minutos
			// int lo convertimos a entero
			int startTime = (int) (new Date().getTime() / 1000);
			workingProyect.put(Integer.parseInt(request.getParameter("start")), startTime);
		} else {
			workingProyect = new HashMap<>();
			int startTime = (int) (new Date().getTime() / 1000);
			workingProyect.put(Integer.parseInt(request.getParameter("start")), startTime);
			session.setAttribute("workingProyect", workingProyect);

		}
	} //Temino el trabajo
	if (request.getParameter("end") != null) {
		int timeEnd = (int) (new Date().getTime() / 1000);
		int idProject = Integer.parseInt(request.getParameter("end"));
		int startTime = workingProyect.get(idProject);
		workingProyect.remove(idProject);
		int totalTime = timeEnd - startTime;
		Project project = DbRepository.find(Project.class, idProject);
		EmployeeProject employeeProject = new EmployeeProject(employee, project, totalTime);

		EmployeeProject ep = DbRepository.find(employeeProject);
		if (ep != null) {
			ep.setMinutes(totalTime);
			DbRepository.update(ep);
		} else {

			DbRepository.add(employeeProject);

		}

		response.sendRedirect("addEmployeeCompany.jsp");
		return;
	}
	%>
	<h1 class="display-2">Projectos en curso</h1>
	<table class="table">
		<thead>
			<tr>

				<th scope="col">Nombre projecto</th>
				<th scope="col">Estado</th>
			</tr>
		</thead>
		<tbody>

			<%
			for (CompanyProject cP : employee.getCompany().getCompanyProject()) {
				Date fechaActual = new Date();
				if (cP.getEnd().before(fechaActual)) {//Es after pero para no tener que cambiar la bbdd
			%>
			<tr>
				<%
				//Si hay proyectos en la session
				if (workingProyect != null) {
					//Miramos si esta trabajando o no
				%>
				<form>
					<td><%=cP.getProject().getName()%></td>
					<%
					if (workingProyect.get(cP.getProject().getId()) == null) {
					%>
					<td><button value="<%=cP.getProject().getId()%>" name="start"
							type="submit" class="btn btn-success">Empezar a Trabajar</button>
					</td>
					<%
					} else {
					%>
					<td><button value="<%=cP.getProject().getId()%>" name="end"
							type="submit" class="btn btn-danger">Terminar de
							Trabajar</button></td>
					<%
					}
					%>
				</form>
				<%
				//Si no hay proyectos en la session
				} else {
				%>
				<form>
					<td><%=cP.getProject().getName()%></td>
					<td><button value="<%=cP.getProject().getId()%>" name="start"
							type="submit" class="btn btn-success">Empezar a Trabajar</button>
					</td>
				</form>
				<%
				}
				%>
			</tr>
			<%
			}
			}
			%>
		</tbody>
	</table>

	<div class="text-center">
		<a href="listCompany.jsp"><button
				class="btn btn-primary btn-lg btn btn-info" name="closeSession"
				type="submit">Atras</button></a>

	</div>

 









	<%--  <%
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
		
		session.removeAttribute("project");
		response.sendRedirect("listCompany.jsp");
		return; 
	}else if(request.getParameter("go")!=null || session.getAttribute("project")!=null ){
		if(session.getAttribute("project")==null){
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
		}
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
		<option disabled="disabled" selected>Projectos</option>
		<% for(CompanyProject cP : employee.getCompany().getCompanyProject()){ 
			Date fechaActual = new Date();
			if(cP.getEnd().before(fechaActual)){//Es after pero para no tener que cambiar la bbdd
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
	%>  --%>
 
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

</body>
</html>