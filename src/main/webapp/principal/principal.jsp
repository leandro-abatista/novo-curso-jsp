<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#myBtn").click(function() {
				$("#myAlert").alert("close");
			});
		});
	</script>
</head>
<body>
	<!-- mensagem de autenticação com sucesso -->
	<div class="m-4">
		<div id="myAlert" class="alert alert-success alert-dismissible d-flex align-items-center fade show">
	      	<i class="bi-check-circle-fill"></i>
	        <strong class="mx-2">${msg}</strong>
	        <button type="button" class="btn-close" id="myBtn"></button>
	    </div>
    </div>
	<h2>Tela principal após login autenticado</h2>
</body>
</html>