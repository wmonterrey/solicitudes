<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<jsp:include page="../fragments/headTag.jsp" />
<!-- Styles required by this views -->
<spring:url value="/resources/vendors/css/select2.min.css" var="select2css" />
<link href="${select2css}" rel="stylesheet" type="text/css"/>
<spring:url value="/resources/vendors/css/datepicker.css" var="datepickercss" />
<link href="${datepickercss}" rel="stylesheet" type="text/css"/>
</head>
<!-- BODY options, add following classes to body to change options

// Header options
1. '.header-fixed'					- Fixed Header

// Brand options
1. '.brand-minimized'       - Minimized brand (Only symbol)

// Sidebar options
1. '.sidebar-fixed'					- Fixed Sidebar
2. '.sidebar-hidden'				- Hidden Sidebar
3. '.sidebar-off-canvas'		- Off Canvas Sidebar
4. '.sidebar-minimized'			- Minimized Sidebar (Only icons)
5. '.sidebar-compact'			  - Compact Sidebar

// Aside options
1. '.aside-menu-fixed'			- Fixed Aside Menu
2. '.aside-menu-hidden'			- Hidden Aside Menu
3. '.aside-menu-off-canvas'	- Off Canvas Aside Menu

// Breadcrumb options
1. '.breadcrumb-fixed'			- Fixed Breadcrumb

// Footer options
1. '.footer-fixed'					- Fixed footer

-->
<body class="app header-fixed sidebar-fixed aside-menu-fixed aside-menu-hidden">
  <!-- Header -->
  <jsp:include page="../fragments/bodyHeader.jsp" />
  <div class="app-body">
  	<!-- Navigation -->
  	<jsp:include page="../fragments/sideBar.jsp" />
    <!-- Main content -->
    <main class="main">
	  <spring:url value="/procesos/compras/saveCompra/" var="saveCompraUrl"></spring:url>
	  <spring:url value="/procesos/compras/" var="comprasPendUrl"></spring:url>
      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item"><a href="<spring:url value="/procesos/compras/" htmlEscape="true "/>"><spring:message code="process.shop" /></a></li>
        <li class="breadcrumb-item active"><c:out value="${compra.item.codigoBrand}" /></li>
        <!-- Breadcrumb Menu-->
        <li class="breadcrumb-menu d-md-down-none">
          <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <a class="btn" href="#"><i class="icon-speech"></i></a>
            <a class="btn" href="<spring:url value="/" htmlEscape="true "/>"><i class="icon-graph"></i> &nbsp;<spring:message code="dashboard" /></a>
            <a class="btn" href="<spring:url value="/logout" htmlEscape="true" />"><i class="icon-logout"></i> &nbsp;<spring:message code="logout" /></a>
          </div>
        </li>
      </ol>
	  <!-- Container -->
      <div class="container-fluid">

        <div class="animated fadeIn">
          <div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-header">
                  <i class="icon-basket"></i> <spring:message code="shopThis" />
                  <div class="card-actions">
                    
                  </div>
                </div>
                <div class="card-body">

                  <div class="row">

                    <div class="col-md-8">
                      <form action="#" autocomplete="off" id="add-shop-form">   
                        
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="idCompra" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-key"></i></span>
	                        	<input type="text" id="idCompra" name="idCompra" readonly autocomplete="idCompra" value="${compra.idCompra}" class="form-control" placeholder="<spring:message code="idCompra" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="insumo" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                        <select name="idInsumo" id="selInsumo" class="form-control select2-single">
			                    	<option value=""><spring:message code="empty"/></option>
			                    	<c:choose>
										<c:when test="${cookie.eSolicitudesLang.value == 'en'}">
											<c:forEach items="${insumos}" var="insumo">
												<c:choose> 
													<c:when test="${insumo.idInsumo eq item.insumo.idInsumo}">
														<option selected value="${insumo.idInsumo}">${insumo.codigoBrand} - ${insumo.nombreInsumoEn} - ${insumo.casaBrand} - ${insumo.codigoLocal}</option>
													</c:when>
													<c:otherwise>
														<option value="${insumo.idInsumo}">${insumo.codigoBrand} - ${insumo.nombreInsumoEn} - ${insumo.casaBrand} - ${insumo.codigoLocal}</option>
													</c:otherwise>
												</c:choose> 
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach items="${insumos}" var="insumo">
												<c:choose> 
													<c:when test="${insumo.idInsumo eq item.insumo.idInsumo}">
														<option selected value="${insumo.idInsumo}">${insumo.codigoBrand} - ${insumo.nombreInsumoEs} - ${insumo.casaBrand} - ${insumo.codigoLocal}</option>
													</c:when>
													<c:otherwise>
														<option value="${insumo.idInsumo}">${insumo.codigoBrand} - ${insumo.nombreInsumoEs} - ${insumo.casaBrand} - ${insumo.codigoLocal}</option>
													</c:otherwise>
												</c:choose> 
											</c:forEach>
										</c:otherwise>
								  	</c:choose>
			                    </select>
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="fechaCompra" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                      		<fmt:formatDate value="${hoy}" var="datecompra" pattern="dd/MM/yyyy" />
	                        	<input type="text" id="fechaCompra" name="fechaCompra" autocomplete="fechaCompra" value="${datecompra}" class="form-control date-picker" data-date-format="dd/mm/yyyy" data-date-end-date="+0d" placeholder="<spring:message code="fechaCompra" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="lugarCompra" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                        <select name="lugarCompra" id="lugarCompra" class="form-control select2-single">
			                    	<option value=""><spring:message code="empty"/></option>
			                    	<c:forEach items="${centros}" var="centro">									
										<c:choose> 
											<c:when test="${centro.idCentro eq compra.lugarCompra}">
												<option selected value="${centro.idCentro}">${centro.nombreCentro}</option>
											</c:when>
											<c:otherwise>
												<option value="${centro.idCentro}">${centro.nombreCentro}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="cuenta" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                        <select name="cuenta" id="cuenta" class="form-control select2-single">
			                    	<option value=""><spring:message code="empty"/></option>
			                    	<c:forEach items="${cuentas}" var="cuenta">
										<c:choose> 
											<c:when test="${cuenta.idCuenta eq compra.cuenta.idCuenta}">
												<option selected value="${cuenta.idCuenta}">${cuenta.nombreCuenta}</option>
											</c:when>
											<c:otherwise>
												<option value="${cuenta.idCuenta}">${cuenta.nombreCuenta}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div> 	                    
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="proveedor" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                       	<select name="proveedor" id="proveedor" class="form-control select2-single">
			                    	<option value=""></option>
			                    	<c:forEach items="${proveedores}" var="proveedor">
			                    		<c:choose> 
											<c:when test="${proveedor eq compra.proveedor}">
												<option selected value="${proveedor}">${proveedor}</option>
											</c:when>
											<c:otherwise>
												<option value="${proveedor}">${proveedor}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="numFactura" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" value="${compra.numFactura}" id="numFactura" name="numFactura" autocomplete="numFactura" class="form-control" placeholder="<spring:message code="numFactura" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="cantComprada" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-numeric-asc"></i></span>
	                        	<input type="text" value="${compra.cantComprada}" id="cantComprada" name="cantComprada" autocomplete="cantComprada" value="${item.cantAutorizada}" class="form-control" placeholder="<spring:message code="cantComprada" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="presentacion" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                       	<select name="presentacion" id="presentacion" class="form-control select2-single">
			                    	<option value=""></option>
			                    	<c:forEach items="${presentaciones}" var="presentacion">
										<c:choose> 
											<c:when test="${presentacion eq compra.presentacion}">
												<option selected value="${presentacion}">${presentacion}</option>
											</c:when>
											<c:otherwise>
												<option value="${presentacion}">${presentacion}</option>
											</c:otherwise>
										</c:choose> 
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="contenidoPresentacion" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-numeric-asc"></i></span>
	                        	<input type="text" value="${compra.contenidoPresentacion}" id="contenidoPresentacion" name="contenidoPresentacion" autocomplete="contenidoPresentacion" value="${item.contenidoPresentacion}" class="form-control" placeholder="<spring:message code="contenidoPresentacion" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="totalProducto" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-numeric-asc"></i></span>
	                        	<input type="text" value="${compra.totalProducto}" id="totalProducto" name="totalProducto" readonly autocomplete="totalProducto" value="${item.totalProducto}" class="form-control" placeholder="<spring:message code="totalProducto" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="observacionesItem" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" id="observaciones" name="observaciones" autocomplete="observaciones" value="${compra.observaciones}" class="form-control" placeholder="<spring:message code="observacionesItem" />">
	                        </div>
	                      </div>
	                    </div> 
	                    
                        <div class="form-group">
                          <button type="submit" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i>&nbsp;<spring:message code="save" /></button>
						  <a href="${fn:escapeXml(comprasPendUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->
        </div>

      </div>
      <!-- /.conainer-fluid -->
    </main>
    
  </div>
  <!-- Pie de p�gina -->
  <jsp:include page="../fragments/bodyFooter.jsp" />

  <!-- Bootstrap and necessary plugins -->
  <jsp:include page="../fragments/corePlugins.jsp" />
  <jsp:include page="../fragments/bodyUtils.jsp" />

  <!-- GenesisUI main scripts -->
  <spring:url value="/resources/js/app.js" var="App" />
  <script src="${App}" type="text/javascript"></script>
  
  <!-- Lenguaje -->
  <c:choose>
	<c:when test="${cookie.eSolicitudesLang.value == null}">
		<c:set var="lenguaje" value="es"/>
	</c:when>
	<c:otherwise>
		<c:set var="lenguaje" value="${cookie.eSolicitudesLang.value}"/>
	</c:otherwise>
  </c:choose>
  
  <!-- Plugins and scripts required by this views -->
  <spring:url value="/resources/vendors/js/jquery.validate.min.js" var="JQueryValidate" />
  <script src="${JQueryValidate}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/i18n/validation/messages_{language}.js" var="jQValidationLoc">
      <spring:param name="language" value="${lenguaje}" />
  </spring:url>
  <script src="${jQValidationLoc}"></script>
  <spring:url value="/resources/vendors/js/bootstrap-datepicker.js" var="datepicker" />
  <script src="${datepicker}" type="text/javascript"></script>
  
  <script src="${jQValidationLoc}"></script>
  <spring:url value="/resources/vendors/js/select2.min.js" var="Select2" />
  <script src="${Select2}" type="text/javascript"></script>

  <!-- Custom scripts required by this view -->
  <spring:url value="/resources/js/views/Purchases.js" var="processPurchase" />
  <script src="${processPurchase}"></script>
  
<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
<c:set var="presentacion"><spring:message code="presentacion" /></c:set>
<c:set var="proveedor"><spring:message code="proveedor" /></c:set>

<script>
	jQuery(document).ready(function() {
		var parametros = {saveCompraUrl: "${saveCompraUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}",presentacion: "${presentacion}",proveedor: "${proveedor}",
				comprasPendUrl: "${comprasPendUrl}" 
		};
		ProcessPurchase.init(parametros);
	});
</script>
  
</body>
</html>