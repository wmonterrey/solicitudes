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
	  <spring:url value="/super/insumos/saveInsumo/" var="saveInsumoUrl"></spring:url>
  	  <spring:url value="/super/insumos/" var="insumosUrl"/>
  	  <spring:url value="/super/insumos/{idInsumo}/" var="undoUrl">
		<spring:param name="idInsumo" value="${insumo.idInsumo}" />
	  </spring:url>	
      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item"><a href="<spring:url value="/super/insumos/" htmlEscape="true "/>"><spring:message code="itemcat" /></a></li>
        <li class="breadcrumb-item active"><c:out value="${insumo.codigoBrand}" /></li>
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
                  <i class="icon-note"></i> <spring:message code="itemcat" />
                  <div class="card-actions">
                    
                  </div>
                </div>
                <div class="card-body">

                  <div class="row">

                    <div class="col-md-11">
                      <form action="#" id="add-insumo-form"> 
                        
                      	<div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="idInsumo" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-key"></i></span>
	                        	<input type="text" id="idInsumo" name="idInsumo" readonly autocomplete="idInsumo" value="${insumo.idInsumo}" class="form-control" placeholder="<spring:message code="idInsumo" />">
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="nombreInsumoEs" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" id="nombreInsumoEs" name="nombreInsumoEs" autocomplete="nombreInsumoEs" value="${insumo.nombreInsumoEs}" class="form-control" placeholder="<spring:message code="nombreInsumoEs" />">
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="nombreInsumoEn" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" id="nombreInsumoEn" name="nombreInsumoEn" autocomplete="nombreInsumoEn" value="${insumo.nombreInsumoEn}" class="form-control" placeholder="<spring:message code="nombreInsumoEn" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="codigoBrand" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" id="codigoBrand" name="codigoBrand" autocomplete="codigoBrand" value="${insumo.codigoBrand}" class="form-control" placeholder="<spring:message code="codigoBrand" />">
	                        </div>
	                      </div>
	                    </div>     
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="casaBrand" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                       	<select name="casaBrand" id="casaBrand" class="form-control select2-single">
			                    	<option value=""></option>
			                    	<c:forEach items="${marcas}" var="marca">
										<c:choose> 
											<c:when test="${marca eq insumo.casaBrand}">
												<option selected value="${marca}">${marca}</option>
											</c:when>
											<c:otherwise>
												<option value="${marca}">${marca}</option>
											</c:otherwise>
										</c:choose> 
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="codigoDistribuidor" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" id="codigoDistribuidor" name="codigoDistribuidor" autocomplete="codigoDistribuidor" value="${insumo.codigoDistribuidor}" class="form-control" placeholder="<spring:message code="codigoDistribuidor" />">
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="casaDistribuidor" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                       	<select name="casaDistribuidor" id="casaDistribuidor" class="form-control select2-single">
			                    	<option value=""></option>
			                    	<c:forEach items="${casas}" var="casa">
										<c:choose> 
											<c:when test="${casa eq insumo.casaDistribuidor}">
												<option selected value="${casa}">${casa}</option>
											</c:when>
											<c:otherwise>
												<option value="${casa}">${casa}</option>
											</c:otherwise>
										</c:choose> 
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div>
	                     
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="codigoLocal" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                       	<select name="codigoLocal" id="codigoLocal" class="form-control select2-single">
			                    	<option value=""></option>
			                    	<c:forEach items="${categorias}" var="categoria">
										<c:choose> 
											<c:when test="${categoria eq insumo.codigoLocal}">
												<option selected value="${categoria}">${categoria}</option>
											</c:when>
											<c:otherwise>
												<option value="${categoria}">${categoria}</option>
											</c:otherwise>
										</c:choose> 
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="tipoInsumo" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                        <select name="tipoInsumo" id="tipoInsumo" class="form-control select2-single">
			                    	<option value=""><spring:message code="empty"/></option>
			                    	<c:forEach items="${tipos}" var="tipo">
										<c:choose> 
											<c:when test="${tipo.catKey eq insumo.tipoInsumo}">
												<option selected value="${tipo.catKey}"><spring:message code="${tipo.messageKey}" /></option>
											</c:when>
											<c:otherwise>
												<option value="${tipo.catKey}"><spring:message code="${tipo.messageKey}" /></option>
											</c:otherwise>
										</c:choose> 
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="undMedida" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                       	<select name="undMedida" id="undMedida" class="form-control select2-single">
			                    	<option value=""><spring:message code="empty"/></option>
			                    	<c:forEach items="${unidades}" var="unidad">
										<c:choose> 
											<c:when test="${unidad.catKey eq insumo.undMedida}">
												<option selected value="${unidad.catKey}"><spring:message code="${unidad.messageKey}" /></option>
											</c:when>
											<c:otherwise>
												<option value="${unidad.catKey}"><spring:message code="${unidad.messageKey}" /></option>
											</c:otherwise>
										</c:choose> 
									</c:forEach>
			                    </select>
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="nivelAdvertencia" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-numeric-asc"></i></span>
	                        	<input type="text" id="nivelAdvertencia" name="nivelAdvertencia" autocomplete="nivelAdvertencia" value="${insumo.nivelAdvertencia}" class="form-control" placeholder="<spring:message code="nivelAdvertencia" />">
	                        </div>
	                      </div>
	                    </div> 
	                    
	                    
                        <div class="form-group">
                          <button type="submit" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i>&nbsp;<spring:message code="save" /></button>
                          <c:choose> 
							<c:when test="${empty insumo.idInsumo}">
								<a href="${fn:escapeXml(insumosUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
							</c:when>
							<c:otherwise>
								<a href="${fn:escapeXml(undoUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
							</c:otherwise>
						  </c:choose>
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
  <spring:url value="/resources/js/views/Insumos.js" var="processInsumo" />
  <script src="${processInsumo}"></script>
  
<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
<c:set var="casaBrand"><spring:message code="casaBrand" /></c:set>
<c:set var="casaDistribuidor"><spring:message code="casaDistribuidor" /></c:set>
<c:set var="codigoLocal"><spring:message code="codigoLocal" /></c:set>

<script>
	jQuery(document).ready(function() {
		var parametros = {saveInsumoUrl: "${saveInsumoUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}",casaBrand: "${casaBrand}",casaDistribuidor: "${casaDistribuidor}",codigoLocal: "${codigoLocal}",
				insumosUrl: "${insumosUrl}" 
		};
		ProcessInsumo.init(parametros);
	});
</script>
  
</body>
</html>