<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt_BR">

<jsp:include page="../principal/head.jsp"></jsp:include>
<body>

	<div class="card text-center">
		<div class="card-header text-white bg-primary"><h1>Ops!! Ocorreu um erro inesperado!</h1></div>
		<div class="card-body">
				<h4>Entre em contato com o suporte do sistema.</h4>
				<h4 class="card-text">(99) 9.9999-9999 | (99) 9.8888-8888</h4>
				<h4 class="card-text">Suporte 24 horas por dia e 7 dias por semana.</h4>
			<a href="<%= request.getContextPath()%>/principal/principal.jsp" class="btn btn-primary">Página Inicial</a>
		</div>
		<div class="card-footer text-muted">
			<p style="font-size: 15px">Log de erro.</p>
			<textarea title="Log de Erro" rows="10" style="width: 35rem; ">
				<% out.println(request.getAttribute("msg")); %>
			</textarea>
		</div>
	</div>
	
	
</body>
</html>