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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
</head>
<body>
	<%
	Employee e = null;
	ArrayList<Company> company = null;
	if (session.getAttribute("user") == null) {
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesion ");
		return;
	}
	if (request.getParameter("add") != null ) {
		String name = null;
		int idEmployee = -1;
		String lastName = null;
		String email = null;
		String gender = null;
		
		try {
			idEmployee = Integer.parseInt(request.getParameter("idUpdateEmployee"));
			e = DbRepository.find(Employee.class, idEmployee);
			name = request.getParameter("firstName");
			lastName = request.getParameter("lastName");
			email = request.getParameter("email");
			gender = request.getParameter("gender");
			

		} catch (Exception exct) {
			response.sendRedirect("error.jsp?msg=Hay algun parametro en blanco");
			return;
		}
		Date date = null;
		try {
			date = Date.valueOf(request.getParameter("date"));
		} catch (Exception exct) {
			response.sendRedirect("error.jsp?msg=El empleado que quieres actualizar no se encuentra");
			return;
		}
		int idCompany = Integer.parseInt(request.getParameter("company"));
		Company c = DbRepository.find(Company.class, idCompany);
		e = new Employee(idEmployee, name, lastName, email, gender, date, e.getPassword(), c, e.getRole());
		DbRepository.add(Employee.class, e);

		response.sendRedirect("listCompany.jsp");
		return;
	} else if (request.getParameter("updateMyUser") != null) {
		Employee user = (Employee) session.getAttribute("user");
		e = DbRepository.find(Employee.class, user.getId());
		company = (ArrayList<Company>) DbRepository.findAll(Company.class);

	} else if (request.getParameter("add") != null && request.getParameter("password") != null) {
		String name = null;
		int idEmployee = -1;
		String lastName = null;
		String email = null;
		String gender = null;
		String password = null;

		try {
			idEmployee = Integer.parseInt(request.getParameter("idUpdateEmployee"));
			e = DbRepository.find(Employee.class, idEmployee);
			name = request.getParameter("firstName");
			lastName = request.getParameter("lastName");
			email = request.getParameter("email");
			gender = request.getParameter("gender");
			password = request.getParameter("password");

		} catch (Exception exct) {
			response.sendRedirect("error.jsp?msg=Hay algun parametro en blanco");
			return;
		}
		Date date = null;
		try {
			date = Date.valueOf(request.getParameter("date"));
		} catch (Exception exct) {
			response.sendRedirect("error.jsp?msg=El empleado que quieres actualizar no se encuentra");
			return;
		}
		int idCompany = Integer.parseInt(request.getParameter("company"));
		Company c = DbRepository.find(Company.class, idCompany);
		e = new Employee(idEmployee, name, lastName, email, gender, date, password, c, e.getRole());
		session.setAttribute("newUser", e);
		
	%>
	<p class="h2">Cambio de Contraseña</p>
	<form method="post">
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Pon tu antiguo password</label>
			<input placeholder="****" id="password" name="password"
				type="password" class="form-control" required="required" >
		</div>
		<button class="btn btn-primary" name="updatePassword" type="submit">Añadir</button>
	</form>

	<%
	return;
	}else if(request.getParameter("updatePassword")!=null){
		String oldPassword = request.getParameter("password");
		Employee user = (Employee) session.getAttribute("user");
		if(user.getPassword().equals(oldPassword)){
			Employee updateEmployee =(Employee) session.getAttribute("newUser");
			DbRepository.add(Employee.class, updateEmployee);
			session.removeAttribute("newUser");
			response.sendRedirect("listCompany.jsp");
			return;
		}else{
			response.sendRedirect("error.jsp?msg=Esa no es la antigua contraseña");
			return;
		}
		
	} else {

	try {
		int idEmployee = Integer.parseInt(request.getParameter("idEmployee"));
		e = DbRepository.find(Employee.class, idEmployee);
	} catch (Exception exct) {
		response.sendRedirect("error.jsp?msg=El empleado que quieres actualizar no se encuentra");
		return;
	}
	company = (ArrayList<Company>) DbRepository.findAll(Company.class);

	}
	%>
	<form method="post">
		<div class="mb-3">
			<label for="exampleInputEmail1" class="form-label">Id </label> <input
				class="form-control" readonly="readonly" value="<%=e.getId()%>"
				name="idUpdateEmployee" type="text">
		</div>

		<div class="mb-3">
			<label class="form-label">Nombre</label> <input class="form-control"
				value="<%=e.getFirstName()%>" name="firstName" type="text">
		</div>


		<div class="mb-3">
			<label class="form-label">Apellido</label> <input
				class="form-control" value="<%=e.getLastName()%>" name="lastName"
				type="text">
		</div>

		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Password</label>
			<input placeholder="****" id="password" name="password"  
				type="password" class="form-control">
		</div>

		<div class="mb-3">
			<label class="form-label">Email</label> <input class="form-control"
				value="<%=e.getEmail()%>" name="email" type="email">
		</div>

		<div class="mb-3">
			<label class="form-label">Sexo</label>

			<%
			if (e.getGender().equals("Male")) {
			%>
			<div class="form-check">
				<input checked="checked" class="form-check-input" value="Male"
					type="radio" name="gender" id="flexRadioDefault1"> <label
					class="form-check-label" for="flexRadioDefault1"> Hombre </label>
			</div>
			<div class="form-check">
				<input class="form-check-input" value="Female" type="radio"
					name="gender" id="flexRadioDefault1"> <label
					class="form-check-label" for="flexRadioDefault1"> Mujer </label>
			</div>
			<%
			} else {
			%>
			<div class="form-check">
				<input class="form-check-input" value="Male" type="radio"
					name="gender" id="flexRadioDefault1"> <label
					class="form-check-label" for="flexRadioDefault1"> Hombre </label>
			</div>
			<div class="form-check">
				<input checked="checked" class="form-check-input" value="Female"
					type="radio" name="gender" id="flexRadioDefault1"> <label
					class="form-check-label" for="flexRadioDefault1"> Mujer </label>
			</div>
			<%
			}
			%>

		</div>

		<div class="mb-3">
			<label>Fecha nacimiento</label> <input class="form-control"
				value="<%=e.getDateOfBirth()%>" name="date" type="date">
		</div>

		<div>
			<label class="form-label">Compañia</label> <select
				class="form-select" name="company">

				<%
				for (Company c : company) {
					if (e.getCompany().getId() == c.getId()) {
				%>
				<option selected="selected" value="<%=c.getId()%>"><%=c.getName()%></option>
				<%
				} else {
				%>
				<option value="<%=c.getId()%>"><%=c.getName()%></option>
				<%
				}
				}
				%>
			</select>
		</div>

		<button class="btn btn-primary" name="add" type="submit">Añadir</button>
	</form>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>