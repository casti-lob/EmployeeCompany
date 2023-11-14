<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="es.jacaranda.model.Employee"%>
<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.model.Company"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<script>
	function validatePassword() {
		if (document.getElementById('password').value == document
				.getElementById('passwordConfirm').value) {
			document.getElementById('error').hidden = true;
			document.getElementById('send').disabled = false;
		} else {

			document.getElementById('error').hidden = false;
			document.getElementById('send').disabled = true;
		}
	}
</script>
</head>
<body>
	<%
	if (request.getParameter("add") != null) {
		String name = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		Date date = Date.valueOf(request.getParameter("date"));
		int idCompany = Integer.parseInt(request.getParameter("company"));
		Company c = DbRepository.find(Company.class, idCompany);
		String password = DigestUtils.md5Hex(request.getParameter("password"));
		String role = "USER";
		Employee e = new Employee(name, lastName, email, gender, date, password, role, c);

		DbRepository.add(Employee.class, e);
		response.sendRedirect("login.jsp");
	} else {
		ArrayList<Company> result = null;
		try {
			result = (ArrayList<Company>) DbRepository.findAll(Company.class);
		} catch (Exception e) {

		}
	%>

	<form method="post">
		<div class="mb-3">
			<label for="exampleInputEmail1" class="form-label">Nombre </label> <input
				name="firstName" type="text" class="form-control"
				id="exampleInputEmail1" aria-describedby="emailHelp">
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Apellidos</label>
			<input name="lastName" type="text" class="form-control"
				id="exampleInputPassword1">
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Email</label> <input
				name="email" type="email" class="form-control"
				id="exampleInputPassword1">
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Password</label>
			<input id="password" name="password" type="password"
				class="form-control">
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Confirma
				Password</label> <input id="passwordConfirm" name="passwordConfirm"
				type="password" class="form-control" onchange="validatePassword();">
			<div  hidden="true" id="error" class="alert alert-danger" role="alert">A simple danger
				alert—check it out!</div>
			
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Sexo </label>
			<div class="form-check">
				<input class="form-check-input" value="Male" type="radio"
					name="gender" id="flexRadioDefault1"> <label
					class="form-check-label" for="flexRadioDefault1"> Hombre </label>
			</div>
			<div class="form-check">
				<input class="form-check-input" value="Female" type="radio"
					name="gender" id="flexRadioDefault1"> <label
					class="form-check-label" for="flexRadioDefault1"> Mujer </label>
			</div>
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Fecha
				nacimiento </label> <input name="date" type="date" class="form-control"
				id="exampleInputPassword1">
		</div>
		<div class="mb-3">
			<label for="exampleInputPassword1" class="form-label">Compañia
			</label> <select name="company" class="form-select"
				aria-label="Default select example">
				<%
				for (Company c : result) {
				%>
				<option value="<%=c.getId()%>"><%=c.getName()%></option>
				<%
				}
				%>

			</select>
		</div>
		<button name="add" type="submit" class="btn btn-primary">Crear
			cuenta</button>
	</form>

	<%
	}
	%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>