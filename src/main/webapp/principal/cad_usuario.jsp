<%@page import="model.ModelLogin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
											<!-- conteudo das páginas -->

											<strong class="alert" id="mensagem">${mensagem}</strong>


											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Cadastro de Usuários</h4>
												</div>

												<div class="card-body">

													<form class="row g-3" id="formUsuario" method="post"
														action="<%=request.getContextPath()%>/ServletUsuarioController">

														<input type="hidden" id="acao" name="acao" value="">

														<div class="col-md-3">
															<label for="id" class="form-label">Código</label> <input
																type="text" name="id" class="form-control" id="id"
																readonly="readonly" value="${modelLogin.id}">
														</div>

														<div class="col-md-6"></div>

														<div class="col-md-6">
															<label for="nome" class="form-label">Nome</label> <input
																type="text" name="nome" class="form-control" id="nome"
																style="font-weight: bold;" value="${modelLogin.nome}"
																required="required">
														</div>

														<div class="col-md-6">
															<label for="email" class="form-label">E-mail</label> <input
																type="email" name="email" class="form-control"
																id="email" style="font-weight: bold;"
																value="${modelLogin.email}" required="required">
														</div>

														<div class="col-md-6">
															<label for="perfil" class="form-label">Perfil</label> 
															<select
																id="perfil" class="form-select"
																style="font-weight: bold;" name="perfil"
																aria-label="Default select example">

																<option disabled="disabled" selected="selected">Selecione
																	um perfil</option>

																<option value="ADMINISTRADOR"
																	<%ModelLogin modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("ADMINISTRADOR")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>ADMINISTRADOR</option>

																<option value="SECRETARIO(a)"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("SECRETARIO(a)")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>SECRETARIO(a)</option>

																<option value="AUXILIARTI"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIARTI")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	DE TI</option>

																<option value="AUXILIARFINANCEIRO"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIARFINANCEIRO")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	FINANCEIRO</option>

																<option value="AUXILIARLOJA"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIARLOJA")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	DE LOJA</option>

																<option value="AUXILIARCONTABILIDADE"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equalsIgnoreCase("AUXILIARCONTABILIDADE")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	DE CONTABILIDADE</option>

																<option value="ESTOQUISTA"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("ESTOQUISTA")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>ESTOQUISTA</option>

																<option value="ATENDENTE"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("ATENDENTE")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>ATENDENTE</option>
															</select>
														</div>

														<div class="col-md-6">
															<label for="sexo" class="form-label">Gênero</label>
															<div class="form-check">
																<input class="form-check-input" type="radio" name="sexo"
																	id="masculino" value="masculino"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getSexo().equalsIgnoreCase("MASCULINO")) {
																		out.print(" ");
																		out.print("checked=\"checked\"");
																		out.print(" ");
																	}%>>
																<label class="form-check-label" for="masculino">MASCULINO</label>
															</div>
															<div class="form-check">
																<input class="form-check-input" type="radio" name="sexo"
																	id="feminino" value="feminino"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getSexo().equalsIgnoreCase("FEMININO")) {
																		out.print(" ");
																		out.print("checked=\"checked\"");
																		out.print(" ");
																	}%>>
																<label class="form-check-label" for="feminino">FEMININO</label>
															</div>
														</div>

														<div class="col-md-6">
															<label for="login" class="form-label">Login</label> <input
																id="login" type="text" name="login" class="form-control"
																style="font-weight: bold;" value="${modelLogin.login}"
																required="required">
														</div>

														<div class="col-md-6">
															<label for="senha" class="form-label">Senha</label> <input
																type="password" name="senha" class="form-control"
																id="senha" style="font-weight: bold;"
																value="${modelLogin.senha}" required="required">
														</div>

														<div class="d-grid gap-2 d-md-flex justify-content-md-end"
															style="margin-top: 2rem">

															<button type="button"
																class="btn btn-dark waves-effect waves-light btn-lg"
																data-bs-toggle="modal" href="#modalToggle" role="button">Pesquisar</button>

															<button type="button"
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


											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Usuários Cadastrados</h4>
												</div>

												<div class="card-body">
													<!-- tabela de dados usando jstl-->
													<div style="height: 20rem; overflow: scroll;">
														<table id="tabelaViewUser"
															class="table table-dark table-hover">
															<thead>
																<tr>
																	<th scope="col">Código</th>
																	<th scope="col">Nome</th>
																	<th scope="col">E-mail</th>
																	<th scope="col">Login</th>
																	<th scope="col">Ver</th>
																</tr>
															</thead>
															<tbody>
																<!-- torna a tabela dinâmica ml-->
																<c:forEach items="${modelLogins}" var="ml">
																	<tr>
																		<!-- linha -->
																		<td><c:out value="${ml.id}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${ml.nome}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${ml.email}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${ml.login}"></c:out></td>
																		<!-- coluna -->
																		<td><a
																			href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${ml.id}"
																			class="btn btn-secondary" type="button"
																			id="button-addon2">Ver</a></td>
																		<!-- coluna -->
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
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
	<div class="modal fade" id="modalToggle" aria-hidden="true"
		aria-labelledby="modalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #B0C4DE">
					<h5 class="modal-title" id="exampleModalToggleLabel">Pesquisa
						de Usuário</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- corpo da página -->
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Informe o nome para pesquisar"
							aria-label="Informe o nome para pesquisar"
							aria-describedby="button-addon2"
							style="font-weight: bold; font-size: 18px" id="nomeBusca">
						<button class="btn btn-success waves-effect waves-light btn-lg"
							type="button" id="button-addon2" onclick="buscarUsuario();">Buscar</button>
					</div>

					<!-- tabela de dados -->
					<div style="height: 20rem; overflow: scroll;">
						<table id="tabelaUsuarioResultados"
							class="table table-dark table-hover">
							<thead>
								<tr>
									<th scope="col">Código</th>
									<th scope="col">Nome</th>
									<th scope="col">Ver</th>
									<th scope="col">Visualizar</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
					<!-- corpo da página -->
				</div>
				<div style="font-weight: bold; font-size: 15px; margin-left: 15px;">
					<!-- total de registros buscados -->
					<span id="totalResultados"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->

	<!-- Modal 2 detalhes-->
	<div class="modal fade" id="modalToggle1" aria-hidden="true"
		aria-labelledby="modalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #B0C4DE">
					<h5 class="modal-title" id="exampleModalToggleLabel">Dados do
						Usuário</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- corpo da página -->
					<div class="input-group mb-3">

						<span></span>


						<!-- corpo da página -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal">Fechar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal 2-->

	<script type="text/javascript">
	
		function mostrarDados(id) {
			/**/
		}
	
		function verEditar(id) {
			//alert(id);
			const urlAction = document.getElementById('formUsuario').action;
			/*redireciona com javascript e buscar o id no get na servlet*/
			window.location.href = urlAction + '?acao=buscarEditar&id=' + id;
			//alert(window.location.href);
		}
	
		function limparCampoBusca() {
			document.getElementById("nomeBusca").value = '';
		}
	
		function buscarUsuario() {
			var nomeBusca = document.getElementById('nomeBusca').value;
		    
		    if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){ /*Validando que tem que ter valor pra buscar no banco*/
			
			 const urlAction = document.getElementById('formUsuario').action;
			
			 $.ajax({
			     
			     method: 'get',
			     url : urlAction,
			     data : 'nomeBusca=' + nomeBusca + '&acao=buscaUsuarioComAjax',
			     success: function (response) {
			    	 const json = JSON.parse(response);
				  
				 	$('tabelaUsuarioResultados > tbody > tr').remove();
				 	for(var posicao = 0; posicao < json.length; posicao++){
				 		$('#tabelaUsuarioResultados > tbody').append('<tr><td>'+ json[posicao].id +'</td><td>'+ json[posicao].nome +'</td><td><button type="button" class="btn btn-info" onclick="verEditar('+json[posicao].id+')">Ver</button></td><td><button type="button" class="btn btn-secondary" data-bs-toggle="modal" href="#modalToggle1" role="button" onclick="mostrarDados('+json[posicao].id+')">Detalhes</button></td></tr>');
				 	}
				 	
				 	if(json.length >= 0 && json.length <= 1){
				 		document.getElementById('totalResultados').textContent = json.length + ' Resultado encontrado ';
				 	} 
				 	document.getElementById('totalResultados').textContent = json.length + ' Resultados encontrados ';
				 
			     }
			 
			 //limparCampoBusca();
			     
			 }).fail(function(xhr, status, errorThrown){
			    alert('Erro ao buscar usuário por nome: ' + xhr.responseText);
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
							alert('Erro ao excluir usuário por id: '
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