<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt_BR">
<!--  
<script src="sweetalert2/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="sweetalert2/dist/sweetalert2.min.css">
-->

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
											
											<strong class="alert" id="mensagem">${mensagem}</strong>

											<div class="card" style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header" style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Cadastro de Telefone</h4>
												</div>

												<div class="card-body">
												
													<form class="row g-3" id="formTelefone" method="post" action="<%=request.getContextPath()%>/ServletTelefone">
														
														<div class="col-md-3">
															<label for="id" class="form-label">Código Usuário</label> 
															<input 
																type="text" 
																name="id" 
																style="font-weight: bold;" 
																class="form-control" 
																id="id"
																readonly="readonly" 
																value="${modelUsuario.id}">
														</div>
														
														<div class="col-md-5">
															<label for="nome" class="form-label">Nome Usuário</label> 
															<input
																type="text" 
																name="nome" 
																style="font-weight: bold;" 
																class="form-control" 
																id="nome"
																readonly="readonly"
																value="${modelUsuario.nome}"
																required="required">
														</div>
														
														<div class="col-md-4">
															<label for="numero" class="form-label">Número</label> 
															<input
																type="text" 
																name="numero" 
																style="font-weight: bold;" 
																class="form-control" 
																id="numero"
																required="required"
																maxlength="17" 
																onkeypress="mask(this, mphone);" 
																onblur="mask(this, mphone);">
														</div>
														
														<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 2rem">
														
															<button type="submit"
																class="btn btn-success waves-effect waves-light btn-lg">Gravar</button>
														</div>
														
													</form>
												
												</div>
											</div>
											
											<div class="card" style="font-weight: bold; background-color: #D3D3D3">
												<div class="card-header" style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Telefones Cadastrados</h4>
												</div>

												<div class="card-body">
													<!-- tabela de dados usando jstl-->
													<div style="height: 20rem; overflow: scroll;">
														<table id="tabelaViewFone" class="table table-primary table-hover">
															<thead>
																<tr>
																	<th scope="col">Código</th>
																	<th scope="col">Número</th>
																	<th scope="col">Excluir</th>
																</tr>
															</thead>
															<tbody>
																<!-- torna a tabela dinâmica ml-->
																<c:forEach items="${listaDeTelefones}" var="fone">
																	<tr>
																		<!-- linha -->
																		<td><c:out value="${fone.idFoneUser}"></c:out></td>
																		<!-- coluna -->
																		<td><c:out value="${fone.numero}"></c:out></td>
																		<!-- coluna -->
																		<td>
																			<a
																			href="<%= request.getContextPath() %>/ServletTelefone?acao=excluirTelefone&idTelefone=${fone.idFoneUser}&userPai=${modelUsuario.id}"
																			class="btn btn-danger" type="button"
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
		$(document).ready(function(){  // A DIFERENÇA ESTA AQUI, EXECUTA QUANDO O DOCUMENTO ESTA "PRONTO"
			  $( "mensagem" ).fadeIn( 300 ).delay( 2500 ).fadeOut( 400 );
		});
	
		function mask(o, f) {
			  setTimeout(function() {
			    var v = mphone(o.value);
			    if (v != o.value) {
			      o.value = v;
			    }
			  }, 1);
			}

			function mphone(v) {
			  var r = v.replace(/\D/g, "");
			  r = r.replace(/^0/, "");
			  if (r.length > 10) {
			    r = r.replace(/^(\d\d)(\d{5})(\d{4}).*/, "($1) $2-$3");
			  } else if (r.length > 5) {
			    r = r.replace(/^(\d\d)(\d{4})(\d{0,4}).*/, "($1) $2-$3");
			  } else if (r.length > 2) {
			    r = r.replace(/^(\d\d)(\d{0,5})/, "($1) $2");
			  } else {
			    r = r.replace(/^(\d*)/, "($1");
			  }
			  return r;
			}
	</script>

</body>

</html>
