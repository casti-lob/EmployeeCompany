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
<body>
	<%
		if(request.getParameter("login")!=null){
			int user= -1;
			String password= null;
			try{
				user= Integer.parseInt(request.getParameter("user"));
				password= request.getParameter("password");
				try{
					Employee employee = DbRepository.find(Employee.class, user);
					if(employee.getPassword().equals(password)){
						session.setAttribute("user",employee );
						response.sendRedirect("listCompany.jsp");
					}else{%>
					<h1>Usuario o Password mal</h1>
						<form action="" method="post">
						<p>
						
							ID Usuario
							<input type="text" name="user" required="required"">
						</p>
						
						<p>
							Password
							<input type="password" name="password" required="required">
						</p>
						<button name="login" type="submit">Iniciar sesión</button>
					</form>
					<%}
				}catch(Exception e){
					response.sendRedirect("error.jsp?msg=El usuario o contraseña están mal");
					return;
				}
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg=Hay algun parametro en blanco");
				return;
			}
		}else{
	%>
	<form action="" method="post">
		<p>
			Usuario
			<input type="text" name="user" required="required"">
		</p>
		
		<p>
			Password
			<input type="password" name="password" required="required">
		</p>
		<button name="login" type="submit">Iniciar sesión</button>
	</form>
	<%} %>
</body>
</html>