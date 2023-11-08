<%@page import="java.util.HashMap"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
</head>
<body>
	<%
	HashMap<Integer, Integer> workingProyect = (HashMap<Integer, Integer>) session.getAttribute("workingProyect");
	if(workingProyect==null){
		workingProyect = new HashMap<>();
	}
	if (request.getParameter("closeSession") != null) {

		session.invalidate();
		response.sendRedirect("login.jsp");
		return;

	}
	if (session.getAttribute("user") == null) {
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}

	Employee user = (Employee) session.getAttribute("user");
	ArrayList<Company> result = null;
	try {

		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
		ArrayList resultAux = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);

	} catch (Exception e) {

	}
	%>



	<div class="text-center">
		<a href="addEmployeeCompany.jsp"><button
				class="btn btn-primary btn-lg btn btn-info" name="closeSession"
				type="submit">Asignar Trabajo</button></a>


		<%
		if ( workingProyect.size()>=1 ) {
		%>
		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">Cuidado</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						Estas seguro de cerrar sesion con
						<%=workingProyect.size()%>
						trabajos activos
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Atras</button>
						<form action="" method="post">
							<button type="submit" name="closeSession" class="btn btn-primary">Cerrar
								Sesion</button>
						</form>

					</div>
				</div>
			</div>
		</div>
		<button class="btn btn-primary btn-lg btn btn-secondary"
			data-bs-toggle="modal" data-bs-target="#staticBackdrop"
			name="closeSession" type="button">Cerrar session</button>

		<%
		} else {
		%>
		<form action="" method="post">
			<button class="btn btn-primary btn-lg btn btn-secondary"
				name="closeSession" type="submit">Cerrar session</button>
		</form>
		<%
		}
		%>
	</div>

	<%
	for (Company c : result) {
	%>



	<table class="table" style="margin-top: 15px">
		<thead>
			<tr class="table-primary">
				<th scope="col">Nombre Compañia</th>
				<th scope="col">Numero Empleado</th>
				<th scope="col">Num proyecto</th>

			</tr>
		</thead>
		<tbody>
			<tr class="table-primary">
				<td><%=c.getName()%></td>
				<td><%=c.getEmployee().size()%></td>
				<td><%=c.getCompanyProject().size()%></td>
			</tr>
			<tr class="table-secondary">
				<th colspan="3">Empleados</th>
			</tr>
			<%
			for (Employee e : c.getEmployee()) {
			%>
			<tr class="table-secondary">
				<%
				if (user.getRole().equals("ADMIN")) {
				%>
				<td colspan="1">Empleado: <%=e.getFirstName()%> <%=e.getLastName()%>
				</td>
				<td><a href="updateEmployee.jsp?idEmployee=<%=e.getId()%>"><button
							class="btn btn-warning" type="button">Editar</button></a></td>
				<td><a href="deleteEmployee.jsp?idEmployee=<%=e.getId()%>"><button
							class="btn btn-danger" type="button">Eliminar</button></a></td>
				<%
				} else {
				%>
				<td colspan="3">Empleado: <%=e.getFirstName()%> <%=e.getLastName()%>
				</td>
				<%
				}
				%>
			</tr>
			<%
			}
			%>
			<tr class="table-success">
				<th colspan="3">Proyectos</th>
			</tr>
			<%
			for (CompanyProject compP : c.getCompanyProject()) {
			%>
			<tr class="table-success">
				<td colspan="3"><%=compP.getProject().getName()%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<%
	}
	%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>