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
	  <spring:url value="/admin/catalogos/saveCatalogo" var="saveCatalogoUrl"></spring:url>
  	  <spring:url value="/admin/catalogos/editCatalogo/{messageKey}/" var="catalogoUrl">
         <spring:param name="messageKey" value="${catalogo.messageKey}" />
      </spring:url>
      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item active"><spring:message code="seccatalogsform" /></li>
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
                  <i class="fa fa-archive"></i> <spring:message code="edit" /> <spring:message code="seccatalogs" />
                  <div class="card-actions">
                    
                  </div>
                </div>
                <div class="card-body">

                  <div class="row">

                    <div class="col-md-8">
                      <form action="#" autocomplete="off" id="edit-mensaje-form">                      
						<div class="form-group row">
	                      <label class="col-md-3 col-form-label" for="messageKey"><strong><spring:message code="messageKey" /></strong></label>
	                      <div class="col-md-9">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-key"></i></span>
	                        	<input type="text" id="messageKey" name="messageKey" value="${catalogo.messageKey}_XX" class="form-control" placeholder="<spring:message code="messageKey" />">
	                        	<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        </div>
	                        <span class="help-block"></span>
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label class="col-md-3 col-form-label" for="catRoot"><strong><spring:message code="catRoot" /></strong></label>
	                      <div class="col-md-9">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-archive"></i></span>
	                        	<input type="text" id="catRoot" readonly name="catRoot" value="${catalogo.messageKey}" class="form-control" placeholder="<spring:message code="catRoot" />">
	                        	<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        </div>
	                        <span class="help-block"></span>
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label class="col-md-3 col-form-label" for="catKey"><strong><spring:message code="catKey" /></strong></label>
	                      <div class="col-md-9">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-info"></i></span>
	                        	<input type="text" id="catKey" name="catKey" value="${catalogo.messageKey}" class="form-control" placeholder="<spring:message code="catKey" />">
	                        	<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        </div>
	                        <span class="help-block"></span>
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label class="col-md-3 col-form-label" for="spanish"><strong><spring:message code="spanish" /></strong></label>
	                      <div class="col-md-9">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-flag"></i></span>
	                        	<input type="text" id="spanish" name="spanish"  class="form-control" placeholder="<spring:message code="spanish" />">
	                        	<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        </div>
	                        <span class="help-block"></span>
	                      </div>
	                    </div>
	                    <div class="form-group row">
	                      <label class="col-md-3 col-form-label" for="english"><strong><spring:message code="english" /></strong></label>
	                      <div class="col-md-9">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-flag"></i></span>
	                        	<input type="text" id="english" name="english"  class="form-control" placeholder="<spring:message code="english" />">
	                        	<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        </div>
	                        <span class="help-block"></span>
	                      </div>
	                    </div>
	                    <input type="text" hidden id="isCat" name="isCat" value="0">
	                    <input type="text" hidden id="pasive" name="pasive" value="0">
	                    <div class="form-group row">
	                      <label class="col-md-3 col-form-label" for="order"><strong><spring:message code="order" /></strong></label>
	                      <div class="col-md-9">
	                      	<div class="input-group">
	                      		<span class="input-group-addon"><i class="fa fa-sort-numeric-asc"></i></span>
	                        	<input type="text" id="order" name="order"  class="form-control" placeholder="<spring:message code="order" />">
	                        	<span class="input-group-addon"><i class="fa fa-sort-alpha-asc"></i></span>
	                        </div>
	                        <span class="help-block"></span>
	                      </div>
	                    </div>
                        <div class="form-group">
                          <button type="submit" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i>&nbsp;<spring:message code="save" /></button>
						  <a href="${fn:escapeXml(catalogoUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
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
  <spring:url value="/resources/js/views/Mensaje.js" var="processMensaje" />
  <script src="${processMensaje}"></script>
  
<c:set var="successmessage"><spring:message code="process.success" /></c:set>
<c:set var="errormessage"><spring:message code="process.errors" /></c:set>
<c:set var="waitmessage"><spring:message code="process.wait" /></c:set>

<script>
	jQuery(document).ready(function() {
		var parametros = {saveMensajeUrl: "${saveCatalogoUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}",
				mensajesUrl: "${catalogoUrl}" 
		};
		ProcessMensaje.init(parametros);
	});
</script>
  
</body>
</html>