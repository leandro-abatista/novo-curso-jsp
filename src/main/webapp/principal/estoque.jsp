<%@page import="model.Ajuste"%>
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
											 
											<!-- 
											<c:if test="${mensagem != null && mensagem != ' '}">
												<div class="alert alert-success fade show" role="alert">
													<strong class="alert" id="mensagem">${mensagem}</strong>
													<button type="button" class="close" data-dismiss="alert" aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
											</c:if>
											 -->
											 

											<div class="card" style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Dados Produto</h4>
												</div>

												<div class="card-body">
												

													<form class="row g-3" id="formEstoque" method="post"
													 action="<%= request.getContextPath()%>/ServletEstoqueProduto">
													 
													 	<input type="hidden" id="acao" name="acao" value="">
													
														<div class="col-md-3">
																<label for="id" class="form-label">Código:</label> 
																<input
																	type="text" 
																	name="id" 
																	style="font-weight: bold;"
																	class="form-control" 
																	id="id" 
																	value="${ajuste.id}"
																	readonly="readonly">
														</div>
														
														<div class="col-md-9">
																<label for="produto" class="form-label">Produto:</label> 
																<select
																	id="produto" 
																	class="form-select"
																	style="font-weight: bold;" 
																	name="produto"
																	aria-label="Default select example">
	
																	<option disabled="disabled" selected="selected">Selecione</option>
																	
																	<c:forEach var="produtos" items="${listaDeProdutos}">
																	<option id="${produtos.id}"
																	value="${produtos.id}">Código-${produtos.id} | Descrição-${produtos.descricao}
																		
																		<c:if test="${produtos.id == idproduto}">
																			<c:out value="selected=selected"/>
																		</c:if>
																	
																	</option>
																	</c:forEach>			
																	
																</select>
															</div>
															
															<div class="col-md-6">
																<label for="movimentacao" class="form-label">Movimentação:</label> 
																<select
																	id="movimentacao" 
																	class="form-select"
																	style="font-weight: bold;" 
																	name="movimentacao"
																	aria-label="Default select example">
	
																	<option disabled="disabled" selected="selected">Selecione</option>
	
																	<option value="Entrada"
																		<%
																		if(request.getParameter("Entrada") != null){
																		Ajuste ajuste = (Ajuste) request.getAttribute("ajuste");
																		if (ajuste != null && ajuste.getMovimentacao().equalsIgnoreCase("Entrada")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}
																		%>>Entrada</option>
	
																	<option value="Saida"
																		<%
																		if(request.getParameter("Saida") != null){
																			Ajuste ajuste = (Ajuste) request.getAttribute("ajuste");
																		if (ajuste != null && ajuste.getMovimentacao().equalsIgnoreCase("Saida")) {
																			out.print(" ");
																			out.print("selected=\"selected\"");
																			out.print(" ");
																		}
																		}
																		%>>Saída</option>
																</select>
															</div>
															
															<div class="col-md-6">
																<label for="quantidade" class="form-label">Quantidade de Ajuste:</label> 
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
															
															<div class="d-grid gap-2 d-md-flex" style="margin-top: 2rem">
															<!-- justify-content-md-end deixa os botões do lado direito -->
															
																<button type="submit"
																class="btn btn-dark waves-effect waves-light btn-lg">Ajustar</button>
																
																	
															</div>
													
													</form>

												</div>
											</div>


											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Estoque</h4>
												</div>

											<div class="card-body">
													<!-- tabela de dados usando jstl-->
													<div style="height: 20rem; overflow: scroll;">
														<table id="tabelaViewProduct" class="table table-primary table-hover">
															<thead>
																<tr>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Código</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Quantidade</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Data Ajuste</th>
																	<th style="font-size: 16px; font-weight: bold;" scope="col">Movimentação</th>
																</tr>
															</thead>
															<tbody style="margin-top: 2px;">
																<!-- torna a tabela dinâmica ml-->
																<c:forEach items="${listaDeProdutosAjustados}" var="ajuste">
																	<tr>
																		<!-- linha -->
																		<td><c:out value="${ajuste.id}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${ajuste.quantidade}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${ajuste.dataAjuste}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${ajuste.movimentacao}"></c:out></td>
																		<!-- coluna -->
																	</tr>
																</c:forEach>
															</tbody>
														</table>
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

	

	<script type="text/javascript">
	
		 
		
	</script>

</body>
</html>