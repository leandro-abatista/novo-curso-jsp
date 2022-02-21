<%@page import="model.Produto"%>
<%@page import="model.ModelLogin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt-BR">

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
											
											<c:if test="${mensagem != '' && mensagem != null}">
												<div id="mensagem" class="alert success-alert">
												  <h3><strong>${mensagem}</strong></h3>
												  <a class="close">&times;</a>
												</div>
											</c:if>
											
											<div class="card" style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Cadastro de Produtos</h4>
												</div>

												<div class="card-body">
											
													<form class="row g-3" id="formProduto" method="post" 
														action="<%=request.getContextPath()%>/ServletProdutoController">
																
																<input type="hidden" id="acao" name="acao" value="">
																
																<div class="col-md-3">
																	<label for="id" class="form-label">Código:</label> 
																	<input
																		type="text" 
																		name="id" 
																		style="font-weight: bold;"
																		class="form-control" 
																		id="id" 
																		readonly="readonly"
																		value="${produto.id}">
																</div>
																
																<div class="col-md-9"></div>
																
																<div class="col-md-8">
																<label for="descricao" class="form-label">Descrição:</label> 
																<input
																	type="text" 
																	name="descricao" 
																	class="form-control" 
																	id="descricao"
																	style="font-weight: bold;" 
																	value="${produto.descricao}"
																	required="required">
															</div>
															
															<div class="col-md-4">
																<label for="quantidade" class="form-label">Quantidade:</label> 
																<input
																	type="text" 
																	name="quantidade" 
																	class="form-control" 
																	id="quantidade"
																	style="font-weight: bold;" 
																	value="${produto.quantidade}"
																	required="required"
																	min="1"
																	max="1000"
																	maxlength="4">
															</div>
															
															<div class="col-md-6">
																<label for="dataEntrada" class="form-label">Data Entrada:</label> 
																<input
																	type="date" 
																	name="dataEntrada" 
																	class="form-control"
																	id="dataEntrada" 
																	style="font-weight: bold;"
																	value="${produto.dataEntrada}" 
																	required="required">
															</div>
															
															<div class="col-md-6">
																<label for="perfil" class="form-label">Unidade de Medida:</label> 
																<select
																	id="unidademedida" class="form-select"
																	style="font-weight: bold;" name="unidademedida"
																	aria-label="Default select example">
	
																	<option disabled="disabled" selected="selected">Selecione</option>
	
																	<option value="Caixa"
																		<%
																		if(request.getParameter("produto") != null){
																		Produto produto = (Produto) request.getAttribute("produto");
																		if (produto.getUnidadeMedida().equalsIgnoreCase("Caixa")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}%>>Caixa</option>
	
																	<option value="Pacote"
																		<%
																		if(request.getParameter("produto") != null){
																		Produto produto = (Produto) request.getAttribute("produto");
																		if (produto.getUnidadeMedida().equalsIgnoreCase("Pacote")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}%>>Pacote</option>
	
																	<option value="KG"
																		<%
																		if(request.getParameter("produto") != null){
																		Produto produto = (Produto) request.getAttribute("produto");
																		if (produto.getUnidadeMedida().equalsIgnoreCase("KG")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}%>>KG</option>
	
																	<option value="ML"
																		<%
																		if(request.getParameter("produto") != null){
																		Produto produto = (Produto) request.getAttribute("produto");
																		if (produto.getUnidadeMedida().equalsIgnoreCase("ML")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}
																		%>>ML</option>
	
																	<option value="Litro"
																		<%
																		if(request.getParameter("produto") != null){
																		Produto produto = (Produto) request.getAttribute("produto");
																		if (produto.getUnidadeMedida().equalsIgnoreCase("Litro")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}
																		%>>Litro</option>
	
																	<option value="Pote"
																		<%
																		if(request.getParameter("produto") != null){
																		Produto produto = (Produto) request.getAttribute("produto");
																		if (produto.getUnidadeMedida().equalsIgnoreCase("Pote")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}
																		%>>Pote</option>
	
																	
																</select>
															</div>
															
															<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 2rem">
	
	
																<button type="button"
																	class="btn btn-primary waves-effect waves-light btn-lg"
																	onclick="limparFormulario();">Novo</button>
	
																<button type="submit"
																	class="btn btn-success waves-effect waves-light btn-lg" onclick="salvarProduto();">Gravar</button>
																	
																<button type="button"
																	class="btn btn-dark waves-effect waves-light btn-lg"
																	data-bs-toggle="modal" href="#modalToggle" role="button">Pesquisar</button>
																
																	
															</div>
	
													</form>
												</div>
											</div>
											
											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Produtos Cadastrados</h4>
												</div>

												<div class="card-body">
													<!-- tabela de dados usando jstl-->
													<div style="height: 20rem; overflow: scroll;">
														<table id="tabelaViewUser" class="table table-primary table-hover">
															<thead>
																<tr>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Código</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Descrição</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Quantidade</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Data Entrada</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Unid. Medida</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Ver</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Excluir</th>
																</tr>
															</thead>
															<tbody style="margin-top: 2px;">
																<!-- torna a tabela dinâmica ml-->
																<c:forEach items="${listaDeProdutos}" var="prod">
																	<tr>
																		<!-- linha -->
																		<td><c:out value="${prod.id}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${prod.descricao}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${prod.quantidade}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${prod.dataEntrada}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${prod.unidadeMedida}"></c:out></td>
																		<!-- coluna -->
																		<td>
																			<a
																			href="<%= request.getContextPath() %>/ServletProdutoController?acao=editProduct&id=${prod.id}"
																			class="btn btn-secondary" 
																			type="button"
																			id="button-addon2">Ver</a>
																		</td>
																		<!-- coluna -->
																		<td>
																			<a
																			href="<%= request.getContextPath() %>/ServletProdutoController?acao=deleteProduct&id=${prod.id}"
																			class="btn btn-danger" 
																			type="button"
																			id="button-addon2">Excluir</a>
																		</td>
																		<!-- coluna -->
																	</tr>
																</c:forEach>
															</tbody>
														</table>
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
	
	<!-- Modal 1 ver -->
	<div class="modal fade" id="modalToggle" aria-hidden="true" aria-labelledby="modalToggleLabel" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #B0C4DE">
					<h5 class="modal-title" id="exampleModalToggleLabel">Pesquisar Produto</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- corpo da página -->
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Informe a descrição para pesquisar"
							aria-label="Informe a descrição para pesquisar"
							aria-describedby="button-addon2"
							style="font-size: 18px" id="descricaoBuscaAjax">
							
						<button class="btn btn-success waves-effect waves-light btn-lg"
							type="button" id="button-addon2" onclick="buscarProdutoPelaDescricao();">Buscar</button>
					</div>

					<!-- tabela de dados -->
					<div style="height: 20rem; overflow: scroll;">
						<table id="tabelaDeResultadosProdutos" class="table table-primary table-hover">
							<thead><!-- cabeçalho da tabela -->
								<tr>
									<th style="font-size: 16px; font-weight: bold;" scope="col">Código</th>
									<th style="font-size: 16px; font-weight: bold;" scope="col">Descrição</th>
									<th style="font-size: 16px; font-weight: bold;" scope="col">Quantidade</th>
									<th style="font-size: 16px; font-weight: bold;" scope="col">Unid. Medida</th>
									<th style="font-size: 16px; font-weight: bold;" scope="col">Ver</th>
								</tr>
							</thead>
							<tbody><!-- dados da tabela -->
							</tbody>
							<tfoot>
							</tfoot>
						</table>
					</div>
					<!-- corpo da página -->
				</div>
				<!-- 
				<nav aria-label="Page navigation example">
						<ul id="ulPaginacaoUserAjax" class="pagination pagination-sm justify-content-center">

						</ul>
					</nav>
				
				<div style="font-size: 16px; margin-left: 15px;">
					<!-- total de registros buscados -
					<p id="totalResultados"></p>
				</div>
				 -->
				
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal 1 ver -->
	
	
	<!-- Início Modal de confirmação de exclusão de registro -->
	<div class="modal modal-danger fade" id="modalExclusao" aria-hidden="true" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog  modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">

					<h5 class="modal-title" id="TituloModalCentralizado">Confirmar exclusão</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Fechar">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>

				<div class="modal-body">
					<h6>
						Deseja excluir o registro
						<c:out value="${prod.id} - ${prod.descricao}" />
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
	<!-- Fim do Modal de confirmação de exclusão de registro -->

	
	
   
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.1.9/sweetalert2.all.min.js" 
   	integrity="sha512-IZ95TbsPTDl3eT5GwqTJH/14xZ2feLEGJRbII6bRKtE/HC6x3N4cHye7yyikadgAsuiddCY2+6gMntpVHL1gHw==" 
   	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script type="text/javascript">
	
	function buscarProdutoPelaDescricao() {
		
		var descricaoBuscaAjax = document.getElementById('descricaoBuscaAjax').value;
		
		if (descricaoBuscaAjax != null && descricaoBuscaAjax != '' && descricaoBuscaAjax.trim() != '') {
			
			var urlAction = document.getElementById('formProduto').action;
			
			$.ajax({
				
				method: "GET",
				url: urlAction,
				data: 'descricaoBuscaAjax=' + descricaoBuscaAjax + '&acao=searchProductAjax',
				success: function (response, textStatus, xhr) {
					
					var json = JSON.parse(response);
					
					$("#tabelaDeResultadosProdutos > tbody > tr").remove();
					$('#descricaoBuscaAjax').reset();
					
					for(var posicao = 0; posicao < json.length; posicao++){
				 		$("#tabelaDeResultadosProdutos > tbody")
				 		.append('<tr><td>'+ json[posicao].id +'</td><td>'+ json[posicao].descricao +'</td><td>'+ json[posicao].quantidade +'</td><td>'+ json[posicao].unidadeMedida +'</td><td><button type="button" class="btn btn-info" onclick="verEditar('+json[posicao].id+')">Ver</button></td><tr>');
				 	}
					
				}
				
			}).fail(function (xhr, status, errorThrow) {
				alert('Erro ao buscar produto pela descrição :: ' + xhr.responseText);
			})
		}
		
		
	}
	
	function limparFormulario() {
		/*retorna os elementos html dentro do form*/
		var elementos = document.getElementById("formProduto").elements;
		for (posicao = 0; posicao < elementos.length; posicao++) {
			elementos[posicao].value = '';
		}
		$('#descricao').focus();
	}
	
	$(document).ready(function() {
		  $("#quantidade").keyup(function() {
		      $("#quantidade").val(this.value.match(/[0-9]*/));
		  });
		});
	
	$(document).ready(function(){			
	    setTimeout(function() {
		$(".alert").fadeOut("slow", function(){
			$(this).alert('close');
		});				
	    }, 5000);			
	});
		
	
	$('.datepicker').datepicker({
	    format: 'mm/dd/yyyy',
	    startDate: '-3d'
	});
	
	/*
	//CALENDAR COM JQUERY
	$(function() {
	    $("#dataEntrada").datepicker({
	        dateFormat: 'dd/mm/yy',
	        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
	        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
	        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
	        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
	        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
	        nextText: 'Próximo',
	        prevText: 'Anterior',
	        changeMonth: true,
	        changeYear: true
	    });
	});
	
	$("#dataEntrada").change(function () {
		//FORMATANDO O CAMPO DATA NASCIMENTO NA TELA COM JQUERY
		var dataNascimento = $("#dataEntrada").val();//pegamos o valor de data
		var dataFormatada = new Date(dataEntrada);//formata o valor de data
		$("#dataEntrada").val(dataFormatada.toLocaleDateString('pt-BR', {timeZone: 'America/São Paulo'}));
		
		//FOCAR NO CAMPO NOME
		$("#descricao").focus();
	});
	*/
		
	</script>

</body>
</html>