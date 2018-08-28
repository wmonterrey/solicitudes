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
	  <spring:url value="/sols/aprobar/aprobarItem/" var="aprobarItemUrl"></spring:url>
  	  <spring:url value="/sols/aprobar/{idSolicitud}/" var="solicitudUrl">
  	  		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item"><a href="<spring:url value="/sols/aprobar/" htmlEscape="true "/>"><spring:message code="sols.aprob" /></a></li>
        <li class="breadcrumb-item active"><a href="${fn:escapeXml(solicitudUrl)}" htmlEscape="true "/><c:out value="${solicitud.numSolicitud}" /></a></li>
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
                  <i class="icon-note"></i> <spring:message code="approve" /> <spring:message code="itemcat" />
                  <div class="card-actions">
                    
                  </div>
                </div>
                <div class="card-body">

                  <div class="row">

                    <div class="col-md-8">
                      <form action="#" autocomplete="off" id="add-item-form">   
                      
                      	<div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="idSolicitud" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-key"></i></span>
	                        	<input type="text" id="idSolicitud" name="idSolicitud" readonly autocomplete="idSolicitud" value="${solicitud.idSolicitud}" class="form-control" placeholder="<spring:message code="idSolicitud" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="idItem" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-key"></i></span>
	                        	<input type="text" id="idItem" name="idItem" readonly autocomplete="idItem" value="${item.idItem}" class="form-control" placeholder="<spring:message code="idItem" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="numSolicitud" />:</label>
	                      <div class="col-md-10">
	                      	<p class="form-control-static"><strong><c:out value="${solicitud.numSolicitud}" /></strong></p>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="insumo" />:</label>
	                      <div class="col-md-10">
                      		<c:choose>
								<c:when test="${cookie.eSolicitudesLang.value == 'en'}">
									<p class="form-control-static"><strong><c:out value="${item.insumo.nombreInsumoEn}" /></strong></p>
                        		</c:when>
                        		<c:otherwise>
                        			<p class="form-control-static"><strong><c:out value="${item.insumo.nombreInsumoEs}" /></strong></p>
                        		</c:otherwise>
							</c:choose>	                        		
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="cantSolicitada" />:</label>
	                      <div class="col-md-10">
	                      	<input id="cantSolicitada" class="form-control" readonly value="${item.cantSolicitada}"/>
	                      	<p class="form-control-static"><strong><c:out value="${item.presentacion}" /></strong></p>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="ctrCompra" />:</label>
	                      <div class="col-md-10">
	                      	<div>
		                        <select name="ctrCompra" id="ctrCompra" class="form-control select2-single">
			                    	<option value=""><spring:message code="empty"/></option>
			                    	<c:forEach items="${centros}" var="centro">
										<c:choose> 
											<c:when test="${centro.idCentro eq item.ctrCompra.idCentro}">
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
		                 	<label class="col-md-2 col-form-label"><spring:message code="estudio" />:</label>
		                 	<div class="col-md-10">
	                      		<div>
				                    <select id="estudio" name="estudio" class="form-control select2" multiple="true">
				                    	<c:forEach items="${estudios}" var="estudio">
											<c:choose> 
												<c:when test="${fn:contains(item.estudio, estudio.estudio.codEstudio)}">
													<option selected value="${estudio.estudio.codEstudio}">${estudio.estudio.nombreEstudio}</option>
												</c:when>
												<c:otherwise>
													<option value="${estudio.estudio.codEstudio}">${estudio.estudio.nombreEstudio}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
				                    </select>
			                    </div>
			                 </div>
		                </div>
		                
		                <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="cantAprobada" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-numeric-asc"></i></span>
	                        	<input type="text" id="cantAprobada" name="cantAprobada" autocomplete="cantAprobada" value="${item.cantAprobada}" class="form-control" placeholder="<spring:message code="cantAprobada" />">
	                        </div>
	                      </div>
	                    </div>
	                    
	                    <div class="form-group row">
	                      <label class="col-md-2 col-form-label"><spring:message code="observacionesItem" />:</label>
	                      <div class="col-md-10">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        	<input type="text" id="observaciones" name="observaciones" autocomplete="observaciones" value="${item.observaciones}" class="form-control" placeholder="<spring:message code="observacionesItem" />">
	                        </div>
	                      </div>
	                    </div>
	                    
                        <div class="form-group">
                          <button type="submit" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i>&nbsp;<spring:message code="save" /></button>
						  <a href="${fn:escapeXml(solicitudUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
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
  <spring:url value="/resources/js/views/Items.js" var="processItem" />
  <script src="${processItem}"></script>
  
<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
<c:set var="presentacion"><spring:message code="presentacion" /></c:set>
<c:set var="estudio"><spring:message code="estudio" /></c:set>

<script>
	jQuery(document).ready(function() {
		var parametros = {saveItemUrl: "${aprobarItemUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}",presentacion: "${presentacion}",estudio: "${estudio}",
				solicitudUrl: "${solicitudUrl}" 
		};
		ProcessItem.init(parametros);
	});
</script>
  
</body>
</html>