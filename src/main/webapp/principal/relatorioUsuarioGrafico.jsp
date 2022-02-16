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

											<div class="card" style="font-weight: bold; background-color: #D3D3D3">
												
												<!-- 
												<div class="card-header" style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Relatório de Usuário</h4>
												</div>
												 -->

												<div class="card-body">
												
													<form class="row g-3" id="formRelUser" method="get" action="<%=request.getContextPath()%>/ServletUsuarioController?acao=imprimirRelUser">
														
														<div class="col-md-4">
															<button type="button" onclick="gerarGrafico();" style="margin-top: 25px" class="btn btn-primary waves-effect waves-light">Gerar Gráfico</button>
														</div>

													</form>
												</div>
											</div>

											<div class="card"
												style="font-weight: bold; background-color: #D3D3D3">

												<div class="card-header"
													style="margin: 0.5rem; font-weight: bold; text-align: center; background-color: #F5F5F5; padding: 0.2rem">
													<h4 class="card-title">Gráfico Salário</h4>
												</div>

												<div>
												  <canvas id="myChart"></canvas>
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
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script type="text/javascript">
	
		//INÍCIO DO JAVASCRIPT DO CHARJ
		
		function gerarGrafico() {
			const myChart = new Chart(
			   document.getElementById('myChart'), 
			   		{
					  type: 'line',
					  data: {
							  labels: [
								  'January',
								  'February',
								  'March',
								  'April',
								  'May',
								  'June',
								],
							  datasets: [{
							    label: 'Gráfico de média salarial por tipo',
							    backgroundColor: 'rgb(255, 99, 132)',
							    borderColor: 'rgb(255, 99, 132)',
							    data: [0, 10, 5, 2, 20, 30, 45],
							  }]
							},
					  options: {}
					}
			);
		}
		//FIM DO JAVASCRIPT DO CHARJS
	
		//CALENDAR COM JQUERY
		$(function() {
		    $("#dataInicial").datepicker({
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
		
		//CALENDAR COM JQUERY
		$(function() {
		    $("#dataFinal").datepicker({
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
