<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../../fragments/headTag.jsp" />
<!-- Styles required by this views -->
<spring:url value="/resources/vendors/css/select2.min.css" var="select2css" />
<link href="${select2css}" rel="stylesheet" type="text/css"/>
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
  <jsp:include page="../../fragments/bodyHeader.jsp" />
  <div class="app-body">
  	<!-- Navigation -->
  	<jsp:include page="../../fragments/sideBar.jsp" />
    <!-- Main content -->
    <main class="main">
	  <spring:url value="/admin/centers/saveCenter/" var="saveCenterUrl"></spring:url>
  	  <spring:url value="/admin/centers/" var="centroUrl"></spring:url>	
      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item"><a href="<spring:url value="/admin/centers/" htmlEscape="true "/>"><spring:message code="centers" /></a></li>
        <li class="breadcrumb-item active"><spring:message code="add" /></li>
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
                  <i class="icon-note"></i> <spring:message code="add" />
                  <div class="card-actions">
                    
                  </div>
                </div>
                <div class="card-body">

                  <div class="row">

                    <div class="col-md-8">
                      <form action="#" autocomplete="off" id="add-center-form">                      
						<div class="form-group">
	                      <div class="input-group">
	                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
	                        <input type="text" id="idCentro" name="idCentro" readonly value="${centro.idCentro}" class="form-control" placeholder="<spring:message code="idCentro" />">
	                      </div>
	                    </div>	
                        <div class="form-group">
	                      <div class="input-group">
	                        <span class="input-group-addon"><i class="fa fa-building"></i></span>
	                        <input type="text" id="nombreCentro" name="nombreCentro" value="${centro.nombreCentro}" class="form-control" placeholder="<spring:message code="nombreCentro" />">
	                      </div>
	                    </div>
	                    <fieldset class="form-group">
                    		<i class="fa fa-hand-o-up"></i>
		                    <label><spring:message code="puedeComprar" /></label>
		                    <select name="puedeComprar" id="puedeComprar" class="form-control select2-single">
		                    	<option value=""><spring:message code="empty"/></option>
		                    	<c:forEach items="${sinos}" var="sino">
									<c:choose> 
										<c:when test="${sino.catKey eq centro.puedeComprar}">
											<option selected value="${sino.catKey}"><spring:message code="${sino.messageKey}" /></option>
										</c:when>
										<c:otherwise>
											<option value="${sino.catKey}"><spring:message code="${sino.messageKey}" /></option>
										</c:otherwise>
									</c:choose> 
								</c:forEach>
		                    </select>
	                  	</fieldset>
	                    <div class="form-group">
	                    	<i class="fa fa-archive"></i>
	                        <label><spring:message code="studies" /></label>
		                    <select id="estudios" name="estudios" class="form-control select2-multiple" multiple="">
		                      <c:forEach items="${estudios}" var="estudio">
		                      	<option value="${estudio.idEstudio}">${estudio.nombreEstudio}</option>
		                      </c:forEach>
		                    </select>
	                    </div>
	                    <div class="form-group">
		                 	<i class="fa fa-group"></i>
		                    <label><spring:message code="users" /></label>
		                    <select id="usuarios" name="usuarios" class="form-control select2-multiple" multiple="">
		                      <c:forEach items="${usuarios}" var="usuario">
		                      	<option value="${usuario.username}">${usuario.completeName}</option>
		                      </c:forEach>
		                    </select>
		                 </div>
                        
                        <div class="form-group">
                          <button type="submit" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i>&nbsp;<spring:message code="save" /></button>
						  <a href="${fn:escapeXml(centroUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
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
  <jsp:include page="../../fragments/bodyFooter.jsp" />

  <!-- Bootstrap and necessary plugins -->
  <jsp:include page="../../fragments/corePlugins.jsp" />
  <jsp:include page="../../fragments/bodyUtils.jsp" />

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
  <spring:url value="/resources/vendors/js/select2.min.js" var="Select2" />
  <script src="${Select2}" type="text/javascript"></script>
  

  <!-- Custom scripts required by this view -->
  <spring:url value="/resources/js/views/Center.js" var="processCenter" />
  <script src="${processCenter}"></script>
  
<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<c:set var="waitmessage"><spring:message code="process.wait" /></c:set>

<script>
	jQuery(document).ready(function() {
		var parametros = {saveCenterUrl: "${saveCenterUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}",
				centroUrl: "${centroUrl}" 
		};
		ProcessCenter.init(parametros);
	});
</script>
  
</body>
</html>