<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@page import="es.jacaranda.model.User"%>
<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.utility.DbUtility"%>
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
	
	if (request.getParameter("login") != null) {
		int user = -1;
		String password = null;
		try {
			user = Integer.parseInt(request.getParameter("user"));
			password = DigestUtils.md5Hex(request.getParameter("password"));
			try {
		Employee employee = DbRepository.find(Employee.class, user);
		if (employee.getPassword().equals(password)) {
			session.setAttribute("user", employee);
			response.sendRedirect("listCompany.jsp");
		} else {
	%>
	<div class="text-center">
		<div class="alert alert-danger d-flex align-items-center" role="alert">
			<svg class="bi flex-shrink-0 me-2" role="img" aria-label="Danger:">
				<use xlink:href="#exclamation-triangle-fill" /></svg>
			<div>Usuario o password invalido</div>
		</div>
		<form action="" method="post">


			<div class="row g-3 align-items-center">
				<div class="col-auto">
					<label for="exampleFormControlInput1" class="col-form-label">Id
						Usuario</label>
				</div>
				<div class="col-auto">
					<input type="text" name="user" class="form-control"
						aria-describedby="idUserHelpInline" required="required">
				</div>

			</div>
			<div class="row g-3 align-items-center">
				<div class="col-auto">
					<label for="inputPassword6" class="col-form-label">Password</label>
				</div>
				<div class="col-auto">
					<input type="password" class="form-control"
						aria-describedby="passwordHelpInline" name="password">
				</div>

			</div>
			<button class="btn btn-primary" type="submit" name="login">Iniciar
				sesión</button>

		</form>
	</div>
	<%
	}
	} catch (Exception e) {
	response.sendRedirect("error.jsp?msg=El usuario o contraseña están mal");
	return;
	}
	} catch (Exception e) {
	response.sendRedirect("error.jsp?msg=Hay algun parametro en blanco");
	return;
	}
	} else {
	%>
	<div class="text-center">
		
		<form action="" method="post">

			
			<div class="row g-3 align-items-center">
				<div class="col-auto">
					<label for="exampleFormControlInput1" class="col-form-label">Id
						Usuario</label>
				</div>
				<div class="col-auto">
					<input type="text" name="user" class="form-control"
						aria-describedby="idUserHelpInline" required="required">
				</div>

			</div>
			<div class="row g-3 align-items-center">
				<div class="col-auto">
					<label for="inputPassword6" class="col-form-label">Password</label>
				</div>
				<div class="col-auto">
					<input type="password" class="form-control"
						aria-describedby="passwordHelpInline" name="password">
				</div>

			</div>
			<button class="btn btn-primary" type="submit" name="login">Iniciar
				sesión</button>
				<a href="addUser.jsp"><button class="btn btn-primary" type="button" >Crear una cuenta</button></a>

		</form>
	</div>
	<%
	}
	%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>