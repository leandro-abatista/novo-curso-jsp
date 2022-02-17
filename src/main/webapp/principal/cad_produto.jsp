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

											<form class="row g-3" id="formProduto" method="post" 
												action="<%=request.getContextPath()%>/ServletProdutoController">

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
																max="1000">
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
														
														<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 2rem">


															<button type="button"
																class="btn btn-primary waves-effect waves-light btn-lg"
																onclick="limparFormulario();">Novo</button>


															<button type="submit"
																class="btn btn-success waves-effect waves-light btn-lg">Gravar</button>
																
														</div>

											</form>

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