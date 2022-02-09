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

											<form class="row g-3" id="formUsuario" method="post" 
												action="<%=request.getContextPath()%>/ServletUsuarioController" enctype="multipart/form-data">

												<div class="col-md-3">
													<label for="id" class="form-label">Código:</label> 
													<input
														type="text" 
														name="id" 
														style="font-weight: bold;"
														class="form-control" 
														id="id" 
														readonly="readonly"
														value="">
												</div>
												
												<div class="col-md-9"></div>
												
												<div class="col-md-6">
															<label for="descricao" class="form-label">Descrição:</label> 
															<input
																type="text" 
																name="descricao" 
																class="form-control" 
																id="descricao"
																style="font-weight: bold;" 
																value=""
																required="required">
														</div>
														
														<div class="col-md-6">
															<label for="quantidade" class="form-label">Quantidade:</label> 
															<input
																type="text" 
																name="quantidade" 
																class="form-control" 
																id="quantidade"
																style="font-weight: bold;" 
																value=""
																required="required">
														</div>
														
														<div class="col-md-6">
															<label for="dataEntrada" class="form-label">Data Entrada:</label> 
															<input
																type="text" 
																name="dataEntrada" 
																class="form-control"
																id="dataEntrada" 
																style="font-weight: bold;"
																value="" 
																required="required">
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
	
		
	</script>

</body>
</html>