<%@page import="es.jacaranda.model.CompanyProject"%>
<%@page import="java.sql.Date"%>
<%@page import="es.jacaranda.model.Project"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="es.jacaranda.repository.DbRepository"%>
<%@page import="es.jacaranda.model.Company"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%if(request.getParameter("add")!=null){ 
		int idCompany =-1;
		int idProject = -1;
		Date begin = null;
		Date end = null;
		Company company=null;
		Project project=null;
		try{
			idCompany = Integer.parseInt(request.getParameter("idCompany"));
			idProject = Integer.parseInt(request.getParameter("idProject"));
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg=Hay algún parametro sin rellenar");
			return;
		}
		try{
			begin =Date.valueOf( request.getParameter("begin"));
			end =Date.valueOf( request.getParameter("end"));
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg=El formato de la fecha tiene que ser dd/mm/yyyy");
			return;
		}
		try{
			company = DbRepository.find(Company.class, idCompany);
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg=No existe la compañia con el id "+idCompany);
			return;
		}
		try{
			project = DbRepository.find(Project.class, idProject);
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg=No existe el proyecto con el id "+idProject);
			return;
		}
		
		CompanyProject compProj = new CompanyProject(company,project,begin,end);
		
		DbRepository.add(CompanyProject.class, compProj);

	}else{
		List<Company> company = DbRepository.findAll(Company.class);
		List<Project> project = DbRepository.findAll(Project.class);
	%>
	<form action="">
	<p>
		Company
		<select name="idCompany">
		<%
			for(Company c : company){
		%>
			<option value="<%=c.getId()%>"><%=c.getName() %></option>
			<%
			} 
			%>
		</select>
	</p>
	
	<p>
		Project
		<select name="idProject">
			<%
				for(Project p: project){
			%>
			<option value="<%=p.getId()%>"><%=p.getName() %></option>
			<%
				}
			%>
		</select>
	</p>
	
	<p>
		Fecha comienzo
		<input name="begin" type="date">
	</p>
	
	<p>
		Fecha finalización
		<input name="end" type="date">
	</p>
		
		<button name="add" type="submit">Añadir</button>
	</form>
	<%} %>
</body>
</html>