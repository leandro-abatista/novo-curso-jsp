<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt_BR">

<head>
	<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

	<jsp:include page="head.jsp"></jsp:include>

	<!-- Pre-loader start -->
	<jsp:include page="theme-loader.jsp"></jsp:include>

	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
			<jsp:include page="navbar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">
					<jsp:include page="navbar2.jsp"></jsp:include>
					<div class="pcoded-content">
						<!-- Page-header start -->
						<jsp:include page="page-header.jsp"></jsp:include>
						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">
										<div class="row">
											<!-- conteudo das páginas -->
											
												<strong id="msg">${mensagem}</strong> 
											

											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">
												
												<div class="card-header" 
												style="margin: 0.5rem; font-weight: bold; text-align: center;  background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Cadastro de Usuários</h4>
												</div>
												
												<div class="card-body">
												
													<form class="row g-3" id="formUsuario" method="post" action="<%= request.getContextPath()%>/ServletUsuarioController">
														
														<input type="hidden" name="acao" value="deletar">
														
														<div class="col-md-3">
															<label for="codigo" class="form-label">Código</label> 
															<input type="text" name="id" class="form-control" id="codigo" readonly="readonly" value="${modelLogin.id}">
														</div>
														
														<div class="col-md-6">
														</div>

														<div class="col-md-6">
															<label for="nome" class="form-label">Nome</label> 
															<input type="text" name="nome" class="form-control" id="nome" 
															style="font-weight: bold;" value="${modelLogin.nome}" required="required">
														</div>

														<div class="col-md-6">
															<label for="email" class="form-label">E-mail</label> 
															<input type="email" name="email" class="form-control" id="email" 
															style="font-weight: bold;" value="${modelLogin.email}" required="required">
														</div>

														<div class="col-md-6">
															<label for="login" class="form-label">Login</label> 
															<input type="text" name="login" class="form-control" id="login" 
															style="font-weight: bold;" value="${modelLogin.login}" required="required">
														</div>

														<div class="col-md-6">
															<label for="senha" class="form-label">Senha</label> <input
																type="password" name="senha" class="form-control" id="senha" 
																style="font-weight: bold;" value="${modelLogin.senha}" required="required">
														</div>

														<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 2rem">
														
															<button type="button" class="btn btn-dark waves-effect waves-light btn-lg" 
															data-bs-toggle="modal" href="#modalToggle" role="button"
															>Pesquisar</button>

															<button  type="button"
																class="btn btn-primary waves-effect waves-light btn-lg"
																onclick="limparFormulario();">Novo</button>

															<button type="submit"
																class="btn btn-danger waves-effect waves-light btn-lg"
																onclick="criarDeleteComAjax();">Excluir</button>

															<button type="submit"
																class="btn btn-success waves-effect waves-light btn-lg">Gravar</button>

														</div>

													</form>
													
												</div>
											</div>


											<!--  fim do conteúdo das páginas -->
										</div>
									</div>
								</div>
								<!-- Page-body end -->
							</div>
							<div id="styleSelector"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="javascriptfile.jsp"></jsp:include>

	<!-- Modal -->
	<div class="modal fade" id="modalToggle" aria-hidden="true" aria-labelledby="modalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #B0C4DE">
					<h5 class="modal-title" id="exampleModalToggleLabel">Pesquisa de Usuário</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- corpo da página -->
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Informe os dados para pesquisa"
							aria-label="Informe os dados para pesquisa"
							aria-describedby="button-addon2"
							style="font-weight: bold;"
							id="nomeBusca">
						<button class="btn btn-success waves-effect waves-light btn-lg" type="button" 
						id="button-addon2" onclick="buscarUsuario();">Buscar</button>
					</div>
					
					<!-- tabela de dados -->
					<table class="table table-dark table-hover">
						<thead>
							<tr>
								<th scope="col">Código</th>
								<th scope="col">Nome</th>
								<th scope="col">Ver</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					<!-- corpo da página -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->

	<script type="text/javascript">
	
		function buscarUsuario() {
			var nomeBusca = document.getElementById('nomeBusca').value;
			
			if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != '') {/*Validando que tem que ter algum valor para buscar no banco de dados*/
				alert('nomeBusca');	
			}
		}
	
		/*usando ajax*/
		function criarDeleteComAjax() {
			if (confirm('Deseja realmente excluir este registro?')) {
				
				var urlAction = document.getElementById('formUsuario').action;
				var idUsuario = document.getElementById('id').value;
				
				$.ajax({
					
					method: "get",
					url: urlAction,
					data: "id=" + idUsuario + '&acao=deletarajax',
					sucess: function(response) {
						//chama o limparFormulario
						limparFormulario();
						document.getElementById('msg').textContent = response;
					}
					
				}).fail(function(xhr, status, errorThrown) {
					alert('Erro ao excluir usuário por id: ' + xhr.responseText);
				});
			}
		}
	
		function deletar() {
			document.getElementById("formUsuario").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formUsuario").submit();
		}
	
		function limparFormulario() {
			var elementos = document.getElementById("formUsuario").elements;/*retorna os elementos html dentro do form*/
			for (posicao = 0; posicao < elementos.length; posicao++) {
				elementos[posicao].value = '';
			}
		}
	
		window.setTimeout(function () {
	    $(".alert").fadeTo(500, 0).slideUp(500, function () {
	        $(this).remove();
	    });
		}, 4000);
		
		/*Iniciará quando todo o corpo do documento HTML estiver pronto.
		$().ready(function() {
			setTimeout(function () {
				$('alert').fadeTo(500, 0).slideUp(500, function () {
			        $(this).remove(); // "mensagemDeGravar" é o id do elemento que seja manipular.
			}, 4000); // O valor é representado em milisegundos.
		});
		*/
	
	</script>
		
</body>

</html>