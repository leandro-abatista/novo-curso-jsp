<%@page import="model.ModelLogin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt_BR">

<jsp:include page="head.jsp"></jsp:include>
	
<body>

	<script type="text/javascript">
	
		$("#dataNascimento").change(function () {
			//FORMATANDO O CAMPO DATA NASCIMENTO NA TELA COM JQUERY
			var dataNascimento = $("#dataNascimento").val();//pegamos o valor de data
			var dataFormatada = new Date(dataNascimento);//formata o valor de data
			$("#dataNascimento").val(dataFormatada.toLocaleDateString('pt-BR', {timeZone: 'UTC'}));
			
			//FOCAR NO CAMPO NOME
			$("#nome").focus();
		});
	
	
	
		//CALENDAR COM JQUERY
		$(function() {
		    $("#dataNascimento").datepicker({
		        dateFormat: 'dd/mm/yy',
		        dayNames: ['Domingo','Segunda','Ter�a','Quarta','Quinta','Sexta','S�bado','Domingo'],
		        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
		        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','S�b','Dom'],
		        monthNames: ['Janeiro','Fevereiro','Mar�o','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		        nextText: 'Pr�ximo',
		        prevText: 'Anterior',
		        changeMonth: true,
		        changeYear: true
		    });
		});
		
		$(document).ready(function(){			
		    setTimeout(function() {
			$(".alert").fadeOut("slow", function(){
				$(this).alert('close');
			});				
		    }, 5000);			
		});
		
	</script>

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
											<!-- 
											
											
											<div class="alert alert-success fade show" role="alert">
												<strong class="alert" id="mensagem">${mensagem}</strong>
												<button type="button" class="close" data-dismiss="alert" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											
											 -->

											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Cadastro de Usu�rios</h4>
												</div>

												<div class="card-body">
												
													<div class="alert alert-danger alert-dismissible fade show" role="alert">
														<strong class="alert" id="mensagem">${mensagem}</strong>
													</div>

													<form class="row g-3" id="formUsuario" method="post"
														action="<%=request.getContextPath()%>/ServletUsuarioController" enctype="multipart/form-data">

														<input type="hidden" id="acao" name="acao" value="">

														<div class="col-md-3">
															<label for="id" class="form-label">C�digo:</label> 
															<input type="text" name="id" style="font-weight: bold;" 
																class="form-control" id="id"
																readonly="readonly" value="${modelLogin.id}">
														</div>
														
														<div class="col-md-9"></div>
														
														<div class="col-md-6">
															<div class="mb-3">
																	<!-- esse if verifica se tem imagem ou n�o -->
																	<c:if test="${modelLogin.fotoUsuario != ' ' && modelLogin.fotoUsuario != null}">
																		<a href="<%= request.getContextPath()%>/ServletUsuarioController?acao=downloadFoto&id=${modelLogin.id}">
																			<img class="border border-secondary border-3" id="fotoEmBase64" alt="Imagem do Usu�rio" style="font-weight: bold;"
																			src="${modelLogin.fotoUsuario}" width="160px" height="120px">
																		</a>
																	</c:if>
																	<!-- se n�o -->
																	<c:if test="${modelLogin.fotoUsuario == ' ' || modelLogin.fotoUsuario == null}">
																		<img class="border border-secondary border-3" id="fotoEmBase64" alt="Imagem do Usu�rio" style="font-weight: bold;"
																		src="assets/images/sem-user2.png" width="160px" height="120px">
																	</c:if>
															</div>
															<div class="mb-3">
																<label for="formFile" style="font-weight: bold;" class="form-label">Selecione uma foto</label>
	  															<input type="file" id="fileFoto" name="fileFoto" class="form-control" accept="image/*" onchange="visualizarImage('fotoEmBase64', 'fileFoto');"  style="font-weight: bold;">
															</div>
														</div>
														
														<div class="col-md-6"></div>

														<div class="col-md-6">
															<label for="nome" class="form-label">Nome:</label> 
															<input
																type="text" 
																name="nome" 
																class="form-control" 
																id="nome"
																style="font-weight: bold;" 
																value="${modelLogin.nome}"
																required="required">
														</div>
														
														<div class="col-md-6">
															<label for="email" class="form-label">E-mail:</label> 
															<input
																type="email" 
																name="email" 
																class="form-control"
																id="email" 
																style="font-weight: bold;"
																value="${modelLogin.email}" 
																required="required"
																x-moz-errormessage="Informe um endere�o de e-mail v�lido.">
														</div>
														
														<div class="col-md-6">
															<label for="dataNascimento" class="form-label">Data Nascimento:</label> 
															<input
																type="text" 
																name="dataNascimento" 
																class="form-control"
																id="dataNascimento" 
																style="font-weight: bold;"
																value="${modelLogin.dataNascimento}" 
																required="required">
														</div>
														
														<div class="col-md-6">
															<label for="rendaMensal" class="form-label">Renda Mensal:</label>
															<input
																type="text" 
																name="rendaMensal" 
																class="form-control" 
																id="rendaMensal"
																style="font-weight: bold;" 
																value="${modelLogin.rendaMensal}"
																required="required">
														</div>

														<div class="col-md-6">
															<label for="perfil" class="form-label">Perfil:</label> 
															<select
																id="perfil" class="form-select"
																style="font-weight: bold;" name="perfil"
																aria-label="Default select example">

																<option disabled="disabled" selected="selected">Selecione um perfil</option>

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

																<option value="AUXILIAR TI"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIAR TI")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	DE TI</option>

																<option value="AUXILIAR FINANCEIRO"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIAR FINANCEIRO")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	FINANCEIRO</option>

																<option value="AUXILIAR LOJA"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIAR LOJA")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>AUXILIAR
																	DE LOJA</option>

																<option value="AUXILIAR CONTABILIDADE"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																	if (modelLogin != null && modelLogin.getPerfil().equalsIgnoreCase("AUXILIAR CONTABILIDADE")) {
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
															<label for="sexo" class="form-label">G�nero:</label>
															<div class="form-check">
																<input class="form-check-input" type="radio" name="sexo"
																	id="masculino" value="MASCULINO"
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
																	id="feminino" value="FEMININO"
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
															<label for="login" class="form-label">Login:</label> <input
																id="login" type="text" name="login" class="form-control"
																style="font-weight: bold;" value="${modelLogin.login}"
																required="required">
														</div>

														<div class="col-md-6">
															<label for="senha" class="form-label">Senha:</label> <input
																type="password" name="senha" class="form-control"
																id="senha" style="font-weight: bold;"
																value="${modelLogin.senha}" required="required">
														</div>
														
														<br>
														<hr style="border-color: #aaa; box-sizing: border-box; width: 100%; height: .3rem"></hr>
														<div style="margin-top: 5px; margin-left: 8px; color: #6495ED; size: 25px">Dados do endere�o</div>
														
														<div class="col-md-3">
															<label class="form-label">Cep:</label>
        													<input class="form-control" style="font-weight: bold;" 
        													name="cep" type="text" id="cep" value="${modelLogin.cep}" 
        													size="10" maxlength="8" onkeypress="$(this).mask('00000000')" onblur="pesquisaCep();"/>
														</div>
														
														<div class="col-md-6">
														</div>
														
														<div class="col-md-6">
															<label class="form-label">Logradouro:</label>
        													<input class="form-control" style="font-weight: bold;" name="logradouro" type="text" id="logradouro" value="${modelLogin.logradouro}" maxlength="200" />
														</div>
														
														<div class="col-md-2">
															<label class="form-label">N�mero:</label>
        													<input class="form-control" style="font-weight: bold;" name="numero" type="text" id="numero" value="${modelLogin.numero}" maxlength="10" />
														</div>
														
														<div class="col-md-4">
															<label class="form-label">Complemento:</label>
        													<input class="form-control" style="font-weight: bold;" name="complemento" type="text" id="complemento" value="${modelLogin.complemento}" maxlength="150" />
														</div>
														
														<div class="col-md-5">
															<label class="form-label">Bairro:</label>
        													<input class="form-control" style="font-weight: bold;" name="bairro" type="text" id="bairro" value="${modelLogin.bairro}" maxlength="30" />
														</div>
														
														<div class="col-md-5">
															<label class="form-label">Cidade:</label>
        													<input class="form-control" style="font-weight: bold;" name="cidade" type="text" id="cidade" value="${modelLogin.cidade}" maxlength="50" />
														</div>
														
														<div class="col-md-2">
															<label class="form-label">Estado:</label>
        													<input class="form-control" style="font-weight: bold;" name="uf" type="text" id="uf" value="${modelLogin.uf}" maxlength="2" />
														</div>

														<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 2rem">

															<button type="button"
																class="btn btn-dark waves-effect waves-light btn-lg"
																data-bs-toggle="modal" href="#modalToggle" role="button">Pesquisar</button>

															<button type="button"
																class="btn btn-primary waves-effect waves-light btn-lg"
																onclick="limparFormulario();">Novo</button>

															<button type="button"
																class="btn btn-danger waves-effect waves-light btn-lg"
																data-bs-toggle="modal" href="#modalExclusao" role="button">Excluir</button>

															<button type="submit"
																class="btn btn-success waves-effect waves-light btn-lg">Gravar</button>
																
															<c:if test="${modelLogin.id > 0}">
																<a href="<%= request.getContextPath() %>/ServletTelefone?idUser=${modelLogin.id}" 
																class="btn btn-info waves-effect waves-light btn-lg">Telefone</a>
															</c:if>		
														</div>

													</form>

												</div>
											</div>


											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Usu�rios Cadastrados</h4>
												</div>

												<div class="card-body">
													<!-- tabela de dados usando jstl-->
													<div style="height: 20rem; overflow: scroll;">
														<table id="tabelaViewUser" class="table table-primary table-hover">
															<thead>
																<tr>
																	<th scope="col">C�digo</th>
																	<th scope="col">Nome</th>
																	<th scope="col">E-mail</th>
																	<th scope="col">Login</th>
																	<th scope="col">Ver</th>
																</tr>
															</thead>
															<tbody>
																<!-- torna a tabela din�mica ml-->
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
																		<td>
																			<a
																			href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${ml.id}"
																			class="btn btn-secondary" type="button"
																			id="button-addon2">Ver</a>
																		</td>
																		<!-- coluna -->
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>

												</div>
												
												<nav aria-label="Page navigation example" style="margin: 18px">
														<ul class="pagination pagination-lg justify-content-center">
															<%
																int totalPagina = (int) request.getAttribute("totalPagina");
																for(int p = 0; p < totalPagina; p++){
																	String url = request.getContextPath() + "/ServletUsuarioController?acao=paginar&pagina=" + (p * 5);
																	out.print("<li class=\"page-item\" ><a class=\"page-link\" href=\"" + url + "\">" + (p + 1) + "</a></li>");
																}
															
															%>
														</ul>
													</nav>
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

	<!-- In�cio Modal de confirma��o de exclus�o de registro -->
	<div class="modal modal-danger fade" id="modalExclusao" aria-hidden="true" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog  modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">

					<h5 class="modal-title" id="TituloModalCentralizado">Confirmar exclus�o</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Fechar">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>

				<div class="modal-body">
					<h6>
						Deseja excluir o registro
						<c:out value="${modelLogin.nome}" />
						?
					</h6>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
					<a type="submit" class="btn btn-danger" onclick="criarDeleteComAjax();">Excluir</a>
				</div>

			</div>
		</div>
	</div>
	<!-- Fim do Modal de confirma��o de exclus�o de registro -->

	<!-- Modal 1 ver -->
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
							style="font-size: 18px" id="nomeBusca">
							
						<button class="btn btn-success waves-effect waves-light btn-lg"
							type="button" id="button-addon2" onclick="buscarUsuario();">Buscar</button>
					</div>

					<!-- tabela de dados -->
					<div style="height: 20rem; overflow: scroll;">
						<table id="tabelaUsuarioResultados" class="table table-primary table-hover">
							<thead><!-- cabe�alho da tabela -->
								<tr>
									<th scope="col">C�digo</th>
									<th scope="col">Nome</th>
									<th scope="col">Ver</th>
								</tr>
							</thead>
							<tbody><!-- dados da tabela -->
							</tbody>
							<tfoot>
							</tfoot>
						</table>
					</div>
					<!-- corpo da p�gina -->
				</div>
				
				<nav aria-label="Page navigation example">
						<ul id="ulPaginacaoUserAjax" class="pagination pagination-sm justify-content-center">

						</ul>
					</nav>
				
				<div style="font-size: 16px; margin-left: 15px;">
					<!-- total de registros buscados -->
					<p id="totalResultados"></p>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal 1 ver -->

	<script type="text/javascript">
	
	
	
	//CAMPO MONEY -> RENDA MENSAL
	$("#rendaMensal").maskMoney({showSymbol:true, symbol:"R$: ", decimal:",", thousands:"."});
	
	//CONSTANTE DE FORMATA��O
	const formatter = new Intl.NumberFormat('pt-BR', {
		currency: 'BRL',
		minimumFractionDigits: 2
	});
	$("#rendaMensal").val(formatter.format($("#rendaMensal").val()));
	//FOCO NO CAMPO RENDAMENSAL
	$("#rendaMensal").focus();
	
	//FUN��O PARA PEGAR APENAS N�MEROS COM JQUERY
	$("#numero, #cep").keypress(function(event){
		return /\d/.test(String.fromCharCode(event.keyCode));
	});
	
	
	$(document).ready(function() {
		
        function limpa_formul�rio_cep() {
            // Limpa valores do formul�rio de cep.
            $("#logradouro").val('');
            $("#numero").val('');
            $("#complemento").val('');
            $("#bairro").val('');
            $("#cidade").val('');
            $("#uf").val('');
            
        }
        
        //Quando o campo cep perde o foco.
        $("#cep").blur(function() {

            //Nova vari�vel "cep" somente com d�gitos.
            var cep = $(this).val().replace(/\D/g, '');

            //Verifica se campo cep possui valor informado.
            if (cep != "") {

                //Express�o regular para validar o CEP.
                var validacep = /^[0-9]{8}$/;

                //Valida o formato do CEP.
                if(validacep.test(cep)) {

                    //Preenche os campos com "..." enquanto consulta webservice.
                    $("#logradouro").val("...");
                    $("#numero").val("...");
                    $("#complemento").val("...");
                    $("#bairro").val("...");
                    $("#cidade").val("...");
                    $("#uf").val("...");

                    //Consulta o webservice viacep.com.br/
                    $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

                        if (!("erro" in dados)) {
                            //Atualiza os campos com os valores da consulta.
                            $("#logradouro").val(dados.logradouro);
                            $("#numero").val(dados.numero);
                            $("#complemento").val(dados.complemento);
                            $("#bairro").val(dados.bairro);
                            $("#cidade").val(dados.localidade);
                            $("#uf").val(dados.uf);
                        } //end if.
                        else {
                            //CEP pesquisado n�o foi encontrado.
                            $("#cep").val('');
                            $("#logradouro").val('');
				            $("#numero").val('');
				            $("#complemento").val('');
				            $("#bairro").val('');
				            $("#cidade").val('');
				            $("#uf").val('');
                            alert("CEP n�o encontrado.");
                            $("#cep").focus();
                        }
                    });
                } //end if.
                else {
                    //cep � inv�lido.
                    limpa_formul�rio_cep();
                    alert("Formato de CEP inv�lido.");
                }
            } //end if.
            else {
                //cep sem valor, limpa formul�rio.
                limpa_formul�rio_cep();
            }
        });
    });
	
		function visualizarImage(fotoEmBase64, fileFoto) {
			var preview = document.getElementById(fotoEmBase64);//campo img do html
			var fileUsuario = document.getElementById(fileFoto).files[0];
			var reader = new FileReader();
			
			reader.onloadend = function () {
				preview.src = reader.result;/*carrega a foto na tela*/
			};
			
			if (fileUsuario) {
				reader.readAsDataURL(fileUsuario);/* preview da imagem*/
			} else {
				preview.src = '';
			}
		}
	
		function verEditar(id) {
			//alert(id);
			const urlAction = document.getElementById('formUsuario').action;
			/*redireciona com javascript e buscar o id no get na servlet*/
			window.location.href = urlAction + '?acao=buscarEditar&id=' + id;
			//alert(window.location.href);
		}
		
		function buscarUserPaginaAjax(url) {
			
			$.ajax({
			     
			     method: "get",
			     url: urlAction,
			     data: url,
			     success: function (response, textStatus, xhr) {
			    	 
			    	var json = JSON.parse(response);
				  
				 	$("#tabelaUsuarioResultados > tbody > tr").remove();
				 	$("#ulPaginacaoAjax > li").remove();
				 	
				 	for(var posicao = 0; posicao < json.length; posicao++){
				 		$("#tabelaUsuarioResultados > tbody").append('<tr><td>'+ json[posicao].id +'</td><td>'+ json[posicao].nome +'</td><td><button type="button" class="btn btn-info" onclick="verEditar('+json[posicao].id+')">Ver</button></td></tr>');
				 	}
				 	
				 	document.getElementById('totalResultados').textContent = json.length + ' Resultados encontrados ';
				 	//o c�digo abaixo, recebe o n�mero de p�ginas da busca
				 	var totalPagina = xhr.getResponseHeader("totalPagina");
				 	
				 	for (var posicao = 0; posicao < totalPagina; posicao++) {
				 		
				 		var url = 'nomeBusca=' + nomeBusca + '&acao=buscaUsuarioComAjaxPage&Pagenation=' + (posicao * 5);
				 		$("#ulPaginacaoUserAjax")
				 		.append(
				 			'<li class="page-item"><a class="page-link" href="#" onclick="buscarUserPaginaAjax(\'' + url + '\')">' + (posicao + 1) + '</a></li>'
				 		);
					}
				 	
				 	if(json.length <= 0){
				 		document.getElementById('totalResultados').textContent = json.length + ' Nenhum resultado encontrado. ';
				 	} else if(json.length <= 1){
				 		document.getElementById('totalResultados').textContent = json.length + ' Resultado encontrado. ';
				 	} else {
				 		document.getElementById('totalResultados').textContent = json.length + ' Resultados encontrados. ';
				 	}
				 	
			     }
			 
			 }).fail(function(xhr, status, errorThrown){
			    alert('Erro ao buscar usu�rio por nome: ' + xhr.responseText);
			 });
			
		}
	
		function buscarUsuario() {
			
			var nomeBusca = document.getElementById('nomeBusca').value;
		    
		    if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){ /*Validando que tem que ter valor pra buscar no banco*/
			
			 var urlAction = document.getElementById('formUsuario').action;
			
			 $.ajax({
			     
			     method: "get",
			     url : urlAction,
			     data : "nomeBusca=" + nomeBusca + '&acao=buscaUsuarioComAjax',
			     success: function (response, textStatus, xhr) {
			    	 
			    	var json = JSON.parse(response);
				  
				 	$("#tabelaUsuarioResultados > tbody > tr").remove();
				 	$("#ulPaginacaoUserAjax > li").remove();
				 	
				 	for(var posicao = 0; posicao < json.length; posicao++){
				 		$("#tabelaUsuarioResultados > tbody").append('<tr><td>'+ json[posicao].id +'</td><td>'+ json[posicao].nome +'</td><td><button type="button" class="btn btn-info" onclick="verEditar('+json[posicao].id+')">Ver</button></td><tr>');
				 	}
				 	
				 	//aqui recebe o n�mero de p�ginas da busca
				 	var totalPagina = xhr.getResponseHeader("totalPagina");
				 	
				 	for (var posicao = 0; posicao < totalPagina; posicao++) {
				 		
				 		var url = 'nomeBusca=' + nomeBusca + '&acao=buscaUsuarioComAjaxPage&Pagenation=' + (posicao * 5);
				 		
						$("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscarUserPaginaAjax(\'' + url + '\')">' + (posicao + 1) + '</a></li>');
					}
				 	
				 	if(json.length <= 0){
				 		document.getElementById('totalResultados').textContent = json.length + ' Nenhum resultado encontrado. ';
				 	} else if(json.length <= 1){
				 		document.getElementById('totalResultados').textContent = json.length + ' Resultado encontrado. ';
				 	} else {
				 		document.getElementById('totalResultados').textContent = json.length + ' Resultados encontrados. ';
				 	}
				 	
			     }
			 
			 }).fail(function(xhr, status, errorThrown){
			    alert('Erro ao buscar usu�rio por nome: ' + xhr.responseText);
			 });
			}
		}

		/*usando ajax*/
		function criarDeleteComAjax() {
			if ($("#modalExclusao")) {

				var urlAction = document.getElementById('formUsuario').action;
				var idUsuario = document.getElementById('id').value;

				$.ajax({

					method : "get",
					url : urlAction,
					data : "id=" + idUsuario + '&acao=deletarComAjax',
					success : function(response) {
						//chama o limparFormulario
						limparFormulario();
						$("#modalExclusao").modal('hide');
						document.getElementById('mensagem').textContent = response;
						$("#nome").focus();
					}

				}).fail(
					function(xhr, status, errorThrown) {
						alert('Erro ao excluir usu�rio por id: ' + xhr.responseText);
				});
			}
		}

		function deletar() {
			document.getElementById("formUsuario").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formUsuario").submit();
		}
		
		function limparFormulario() {
			/*retorna os elementos html dentro do form*/
			var elementos = document.getElementById("formUsuario").elements;
			for (posicao = 0; posicao < elementos.length; posicao++) {
				elementos[posicao].value = '';
			}
			$('#nome').focus();
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