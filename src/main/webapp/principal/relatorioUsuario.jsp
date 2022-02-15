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
											<!-- conteudo das p�ginas -->

											<div class="card" style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header" style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Relat�rio de Usu�rio</h4>
												</div>

												<div class="card-body">
												
													<form class="row g-3" id="formRelUser" method="get" action="<%=request.getContextPath()%>/ServletUsuarioController?acao=imprimirRelUser">
														
														<input 
														id="acaoRelatorioImprimirTipo" 
														type="hidden" 
														name="acao" 
														value="imprimirRelUser">
														
														<div class="col-md-4">
															<label class="form-label" for="dataInicial">Data Inicial:</label>
															<input 
															type="text" 
															class="form-control" 
															id="dataInicial" 
															name="dataInicial"
															>
														</div>
														<div class="col-md-4">
															<label class="form-label" for="dataFinal">Data Final:</label>
															<input 
															type="text" 
															class="form-control"
															id="dataFinal" 
															name="dataFinal"
															>
														</div>
														
														<div class="col-md-4">
															<button type="button" onclick="imprimirHtml();" style="margin-top: 25px" class="btn btn-primary waves-effect waves-light">Imprimir Tela</button>
															<button type="button" onclick="imprimirPdf(); return false;" style="margin-top: 25px" class="btn btn-primary waves-effect waves-light">Imprimir PDF</button>
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
													
													<table id="tabelaViewUser"
																class="table table-primary table-hover"
																style="font-weight: bold;">
																
																<thead>
																	<tr>
																		<th scope="col">C�digo</th>
																		<th scope="col">Nome</th>
																		<th scope="col">E-mail</th>
																	</tr>
																</thead>
																<tbody>
																		<!-- torna a tabela din�mica ml-->
																		<c:forEach items="${listaUser}" var="ml">
																			<tr>
																				<!-- linha -->
																				<td><c:out value="${ml.id}"></c:out></td>
																				<!-- coluna -->
																				<td><c:out value="${ml.nome}"></c:out></td>
																				<!-- coluna -->
																				<td><c:out value="${ml.email}"></c:out></td>
																			</tr>
																			
																				<thead class="table-danger">
																					<tr>
																						<th scope="col">C�digo</th>
																						<th scope="col">N�mero</th>
																						<th></th>
																					</tr>
																				</thead>
																			<c:forEach items="${ml.telefones}" var="fone">
																				<tbody class="table-danger">
																					<tr style="font-style: oblique;">
																						<td>
																							<c:out value="${fone.idFoneUser}"></c:out>
																						</td>
																						<td>
																							<c:out value="${fone.numero}"></c:out>
																						</td>
																						<td></td>
																						</tr>
																				</tbody>
																			</c:forEach>
																		</c:forEach>
															</tbody>
														</table>
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
	
	<script type="text/javascript">
	
	
		function imprimirHtml() {
			document.getElementById("acaoRelatorioImprimirTipo").value = "imprimirRelUser";
			$("#formRelUser").submit();
		}
		
		function imprimirPdf() {
			document.getElementById("acaoRelatorioImprimirTipo").value = "imprimirRelPdf";
			$("#formRelUser").submit();
		}
	
		//CALENDAR COM JQUERY
		$(function() {
		    $("#dataInicial").datepicker({
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
		
		//CALENDAR COM JQUERY
		$(function() {
		    $("#dataFinal").datepicker({
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

</body>

</html>
