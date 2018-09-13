<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../fragments/headTag.jsp" />
<!-- Styles required by this views -->
<spring:url value="/resources/vendors/css/select2.min.css" var="select2css" />
<link href="${select2css}" rel="stylesheet" type="text/css"/>
<spring:url value="/resources/vendors/css/daterangepicker.css" var="dtrpcss" />
<link href="${dtrpcss}" rel="stylesheet" type="text/css"/>
<spring:url value="/resources/vendors/css/dataTables.bootstrap4.min.css" var="dataTablesCSS" />
<link href="${dataTablesCSS}" rel="stylesheet" type="text/css"/>
<spring:url value="/resources/vendors/css/responsive.dataTables.min.css" var="dataTablesResponsiveCSS" />
<link href="${dataTablesResponsiveCSS}" rel="stylesheet" type="text/css"/>

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

      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item active"><spring:message code="process.deliver" /></li>
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
                  <i class="icon-cloud-download"></i> <spring:message code="process.deliver" />
                  <div class="card-actions">
                  </div>
                </div>
                <div class="card-body">
                  <spring:url value="/procesos/entregas/addEntregaa/"	var="newEntrega"/>	
              	  <button id="lista_entregas_new" onclick="location.href='${fn:escapeXml(newEntrega)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-plus"></i>&nbsp; <spring:message code="add" /></button><br><br>
                  <div class="row">
                  	<div class="col-md-10">
	                  	<form action="#" autocomplete="off" id="entregas-form">
		                  	<div class="form-group row">
		                      <div class="input-group">
		                        <span class="input-group-addon"><input type="checkbox" id="checkNumero" name="checkNumero" value=""></span>
		                        <input type="text" id="numRecibo" name="numRecibo" disabled class="form-control" placeholder="<spring:message code="numRecibo" />">
		                      </div>
		                    </div>
	           			  <div class="form-group row">
			                  <label><spring:message code="fechaEntrega" /></label>
			                  <div class="input-group">
			                    <span class="input-group-addon"><input type="checkbox" id="checkDates" name="checkDates" value=""></span>
			                    <input id="fechaCompraRange" name="fechaCompraRange" class="form-control" disabled type="text">
			                  </div>
		                  </div>
		                  <div class="form-group row">
			                  <div class="col-md-3">
			                    <label><spring:message code="usrRecibeItem" /></label>
			                    <select id="usrRecibeItem" name="usrRecibeItem" class="form-control select2-single">
			                    	<option value="ALL"><spring:message code="all"/></option>	
			                    	<c:forEach items="${usuarios}" var="usuario">
			                      		<option value="${usuario.username}">${usuario.completeName}</option>
			                    	</c:forEach>
			                    </select>
			                  </div>
			                  <div class="col-sm-3">
			                    <label><spring:message code="ent" /></label>
			                    <select id="entregado" name="entregado" class="form-control select2-single">
			                    	<option value="ALL"><spring:message code="all"/></option>
			                    	<c:forEach items="${sinos}" var="sino">
			                    		<option value="${sino.catKey}"><spring:message code="${sino.messageKey}" /></option>
									</c:forEach>
			                    </select>
			                  </div>
			                  <div class="col-sm-3">
			                    <label><spring:message code="verificado" /></label>
			                    <select id="verificado" name="verificado" class="form-control select2-single">
			                    	<option value="ALL"><spring:message code="all"/></option>
			                    	<c:forEach items="${sinos}" var="sino">
										<option value="${sino.catKey}"><spring:message code="${sino.messageKey}" /></option>
									</c:forEach>
			                    </select>
			                  </div>
			                  <div class="col-sm-3">
			                    <label><spring:message code="insumo" /></label>
			                    <select id="insumo" name="insumo" class="form-control select2-single">
			                    	<option value="ALL"><spring:message code="all"/></option>
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
		                  <div class="row float-right mr-4" >  
		                    	<button type="submit" class="btn btn-primary" id="buscarentregas""><i class="fa fa-check"></i>&nbsp;<spring:message code="search" /></button>
				          </div>
	                  	</form>
                  	</div>
                  </div>
                </div>
              </div>
			</div>
			</div>
			<div id="resultadosdiv">
			<div class="row">
            <div class="col-md-12">
            	<div class="card">
		            <div class="card-header">
		              <div class="card-actions">
		              </div>
		            </div>
		            <div class="card-body">
		              <table id="resultados" class="table table-striped table-bordered datatable" width="100%">
		                <thead>
		                	<tr>
		                		<th><spring:message code="item" /></th>
			                    <th><spring:message code="usrRecibeItem" /></th>
			                    <th><spring:message code="fechaEntrega" /></th>
			                    <th><spring:message code="numRecibo" /></th>
			                    <th><spring:message code="cantEntregada" /></th>
			                    <th><spring:message code="fechaVerificacion" /></th>
			                    <th><spring:message code="observaciones" /></th>
			                    <th><spring:message code="pasivo" /></th>
			                    <th><spring:message code="createdBy" /></th>
			                    <th><spring:message code="dateCreated" /></th>
								<th></th>
		                	</tr>
		                </thead>
		                <tbody>
		                </tbody>
		              </table>
		            </div>
		          </div>  
			</div>
			</div>
			</div>
        </div>

      </div>
      <!-- /.container-fluid -->
    </main>
  </div>
  <!-- Pie de página -->
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
  <spring:url value="/resources/vendors/js/i18n/datatables/label_{language}.json" var="dataTablesLang">
  	<spring:param name="language" value="${lenguaje}" />
  </spring:url>
  
  <!-- Plugins and scripts required by this views -->
  <spring:url value="/resources/vendors/js/jquery.validate.min.js" var="JQueryValidate" />
  <script src="${JQueryValidate}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/i18n/validation/messages_{language}.js" var="jQValidationLoc">
      <spring:param name="language" value="${lenguaje}" />
  </spring:url>
  <script src="${jQValidationLoc}"></script>
  <spring:url value="/resources/vendors/js/jquery.dataTables.min.js" var="dataTablesSc" />
  <script src="${dataTablesSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.bootstrap4.min.js" var="dataTablesBsSc" />
  <script src="${dataTablesBsSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.responsive.min.js" var="dataTablesResponsive" />
  <script src="${dataTablesResponsive}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/moment.min.js" var="moment" />
  <script src="${moment}" type="text/javascript"></script>  
  <spring:url value="/resources/vendors/js/daterangepicker.min.js" var="drPicker" />
  <script src="${drPicker}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/select2.min.js" var="Select2" />
  <script src="${Select2}" type="text/javascript"></script>
  
  
  <c:set var="successmessage"><spring:message code="process.success" /></c:set>
  <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
  <c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
  <c:set var="noResults"><spring:message code="noResults" /></c:set>
  
  <spring:url value="/procesos/entregas/" var="entregasUrl"/>
  
  <!-- Custom scripts required by this view -->
  <spring:url value="/resources/js/views/BuscarEntregas.js" var="processSearch" />
  <script src="${processSearch}"></script>
  
  <script>
  	jQuery(document).ready(function() {
		var parametros = {entregasUrl: "${entregasUrl}",successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}" ,dataTablesLang: "${dataTablesLang}",noResults: "${noResults}"};
		ProcessSearch.init(parametros);
	});
	
  </script>
</body>
</html>