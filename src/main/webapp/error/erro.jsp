<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Curso-JSP</title>
</head>
<body>
	<h1>Ops!!</h1>
	<br>
	<h2>Mensagem de Erro, entre em contato com o suporte do sistema.</h2>
	<br>
	<h2>(99) 9.9999-9999 | (99) 9.8888-8888</h2>
	<h3>Suporte 24 horas por dia e 7 dias por semana.</h3>
	<br>
	<br>
	
	<%
		out.println(request.getAttribute("msg"));
	%>	
</body>
</html>