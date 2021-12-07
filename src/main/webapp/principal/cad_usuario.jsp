<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt_BR">

<jsp:include page="head.jsp"></jsp:include>
	
<body>

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
											<!-- conteudo das p�ginas -->
											
												<strong class="alert" id="mensagem">${mensagem}</strong> 
											

											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">
												
												<div class="card-header" 
												style="margin: 0.5rem; font-weight: bold; text-align: center;  background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Cadastro de Usu�rios</h4>
												</div>
												
												<div class="card-body">
												
													<form class="row g-3" id="formUsuario" method="post" action="<%= request.getContextPath()%>/ServletUsuarioController">
														
														<input type="hidden" id="acao" name="acao" value="">
														
														<div class="col-md-3">
															<label for="id" class="form-label">C�digo</label> 
															<input type="text" name="id" class="form-control" id="id" readonly="readonly" value="${modelLogin.id}">
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
																data-bs-toggle="modal" href="#modalToggle" role="button">Pesquisar</button>

															<button  type="button" class="btn btn-primary waves-effect waves-light btn-lg"
																onclick="limparFormulario();">Novo</button>

															<button type="submit" class="btn btn-danger waves-effect waves-light btn-lg"
																onclick="criarDeleteComAjax();">Excluir</button>

															<button type="submit" class="btn btn-success waves-effect waves-light btn-lg">Gravar</button>

														</div>

													</form>
													
												</div>
											</div>


											<!--  fim do conte�do das p�ginas -->
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
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #B0C4DE">
					<h5 class="modal-title" id="exampleModalToggleLabel">Pesquisa de Usu�rio</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- corpo da p�gina -->
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Informe o nome para pesquisar"
							aria-label="Informe o nome para pesquisar"
							aria-describedby="button-addon2"
							style="font-weight: bold; font-size: 18px"
							id="nomeBusca">
						<button class="btn btn-success waves-effect waves-light btn-lg" type="button" 
						id="button-addon2" onclick="buscarUsuario();">Buscar</button>
					</div>
					
					<!-- tabela de dados -->
					<div style="height: 20rem; overflow: scroll;">
					<table id="tabelaUsuarioResultados" class="table table-dark table-hover">
						<thead>
							<tr>
								<th scope="col">C�digo</th>
								<th scope="col">Nome</th>
								<th scope="col">Ver</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					</div>
					<!-- corpo da p�gina -->
				</div>
				<div style="font-weight: bold; font-size: 15px; margin: 15px;">
				<!-- total de registros buscados -->
					<span id="totalResultados"></span>
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
		    
		    if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){ /*Validando que tem que ter valor pra buscar no banco*/
			
			 const urlAction = document.getElementById('formUsuario').action;
			
			 $.ajax({
			     
			     method: 'get',
			     url : urlAction,
			     data : 'nomeBusca=' + nomeBusca + '&acao=buscarUsuarioComAjax',
			     success: function (response) {
			    	 const json = JSON.parse(response);
				  
				 	$('tabelaUsuarioResultados > tbody > tr').remove();
				 	for(var posicao = 0; posicao < json.length; posicao++){
				 		$('#tabelaUsuarioResultados > tbody').append('<tr><td>'+ json[posicao].id +'</td><td>'+ json[posicao].nome +'</td><td><button type="button" class="btn btn-info">Ver</button></td><td><button type="button" class="btn btn-secondary">Detalhes</button></td></tr>');
				 	}
				 	
				 	document.getElementById('totalResultados').textContent = json.length + ' Resultados encontrados ';
				 
			     }
			     
			 }).fail(function(xhr, status, errorThrown){
			    alert('Erro ao buscar usu�rio por nome: ' + xhr.responseText);
			 });
			}
		}

		/*usando ajax*/
		function criarDeleteComAjax() {
			if (confirm('Deseja realmente excluir este registro?')) {

				const urlAction = document.getElementById('formUsuario').action;
				const idUsuario = document.getElementById('id').value;

				$.ajax({

					method : "get",
					url : urlAction,
					data : "id=" + idUsuario + '&acao=deletarComAjax',
					success : function(response) {
						//chama o limparFormulario
						limparFormulario();
						document.getElementById('mensagem').textContent = response;
					}

				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao excluir usu�rio por id: '
									+ xhr.responseText);
						});
			}
		}

		function deletar() {
			document.getElementById("formUsuario").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formUsuario").submit();
		}

		function limparFormulario() {
			const elementos = document.getElementById("formUsuario").elements;/*retorna os elementos html dentro do form*/
			for (posicao = 0; posicao < elementos.length; posicao++) {
				elementos[posicao].value = '';
			}
		}

		window.setTimeout(function() {
			$(".alert").fadeTo(500, 0).slideUp(500, function() {
				$(this).remove();
			});
		}, 4000);

		/*Iniciar� quando todo o corpo do documento HTML estiver pronto.
		$().ready(function() {
			setTimeout(function () {
				$('alert').fadeTo(500, 0).slideUp(500, function () {
			        $(this).remove(); // "mensagemDeGravar" � o id do elemento que seja manipular.
			}, 4000); // O valor � representado em milisegundos.
		});
		 */
	</script>

</body>
</html>