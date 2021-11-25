<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Curso-JSP</title>
</head>
<body>

	<h1>Bem vindo ao Sistema de Gerenciamento de Estoque</h1>
	
	<!-- mensagem -->
	<h4>${msg}</h4>
	
	<!-- formulário - enviados dados do formulário para a página receber-nome.jsp-->
	<form action="ServletLogin" method="post"><!--  -->
		<br>
		
		<input type="hidden" value="<%= request.getParameter("url") %>" name="url">
		
		<table>

			<tr>
				<td><label>Login :: </label></td>
				<td><input name="login"></td>
			</tr>

			<tr>
				<td><label>Senha :: </label></td>
				<td><input type="password" name="senha"></td>
			</tr>

			<tr></tr>
			<tr>
				<td><input type="submit" value="Entrar"></td>
			</tr>

		</table>
	</form>
</body>
</html>