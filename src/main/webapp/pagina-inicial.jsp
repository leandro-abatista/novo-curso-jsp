<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Curso-JSP</title>
</head>
<body>

	<h1>Bem vindo ao curso de jsp</h1>
	
	<%
	out.println("Java Seu sucesso garantido - ");
	out.println("");
	out.println("Formu�rio de entrada de dados ::");
	out.println("");
	%>
	
	<!-- formul�rio - enviados dados do formul�rio para a p�gina receber-nome.jsp-->
	<form action="ServletLogin" method="post"><!--  -->
		<br>
		<input name="nome">
		<input name="idade">
		
		<input type="submit" value="enviar">
	</form>
</body>
</html>