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

<style type="text/css">
body {
	margin: 0;
	padding: 0;
	background-color: #17a2b8;
}

#login .container #login-row #login-column #login-box {
	margin-top: 90px;
	max-width: 600px;
	height: 320px;
	border: 1px solid #9C9C9C;
	background-color: #EAEAEA;
}

#login .container #login-row #login-column #login-box #login-form {
	padding: 20px;
}

#login .container #login-row #login-column #login-box #login-form #register-link
	{
	margin-top: -85px;
}
</style>
</head>
<body>

	<div class="alert alert-danger" style="font-weight: bold;" role="alert">
		<strong>${msgLogout}</strong>
	</div>

	<div id="login">
		<div class="container">
			<div id="login-row"
				class="row justify-content-center align-items-center">
				<div id="login-column" class="col-md-6">
					<div id="login-box" class="col-md-12">
						<div class="card-header" style="text-align: center;">
							<h1>Bem vindo ao SGE</h1>
							<h6>Sistema de Gerenciamento de Estoque</h6>
						</div>


						<div class="card-body" style="background-color: #A9A9A9">

							<div class="alert alert-danger" style="font-weight: bold;"
								role="alert">
								<strong>${msg}</strong>
							</div>

							<!-- formulário - enviados dados do formulário para a página receber-nome.jsp-->
							<form action="ServletLogin" method="post"
								class="form needs-validation" novalidate>
								<!--  -->
								<br> <input type="hidden"
									value="<%=request.getParameter("url")%>" name="url">

								<div class="mb-3">
									<label for="login" class="form-label" style="font-weight: bold;">Login :: </label> 
										<input id="login"
										name="login" class="form-control"
										placeholder="Informe seu login" required="required">

									<div class="invalid-feedback">Campo obrigatório</div>
									<div class="valid-feedback">Ok!</div>
								</div>

								<div class="mb-3">
									<label for="senha" class="form-label" style="font-weight: bold;">Senha :: </label> 
										<input id="senha"
										type="password" name="senha" class="form-control"
									    placeholder="Informe sua senha"
										required="required">

									<div class="invalid-feedback">Campo obrigatório</div>
									<div class="valid-feedback">Ok!</div>
								</div>

								<div class="d-grid gap-2">
									<input class="btn btn-primary btn-lg" type="submit" value="Entrar">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    
    <script type="text/javascript">
    
    window.setTimeout(function () {
	    $(".alert").fadeTo(500, 0).slideUp(500, function () {
	        $(this).remove();
	    });
		}, 4000);
    
    /*script de validação dos campos de login e senha*/
    (function () {
    	  'use strict'

    	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
    	  var forms = document.querySelectorAll('.needs-validation')

    	  // Loop over them and prevent submission
    	  Array.prototype.slice.call(forms)
    	    .forEach(function (form) {
    	      form.addEventListener('submit', function (event) {
    	        if (!form.checkValidity()) {
    	          event.preventDefault()
    	          event.stopPropagation()
    	        }

    	        form.classList.add('was-validated')
    	      }, false)
    	    })
    	})()	
    
    </script>
</body>
</html>