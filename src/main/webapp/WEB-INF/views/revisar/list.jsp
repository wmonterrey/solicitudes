<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../fragments/headTag.jsp" />
<!-- Styles required by this views -->
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
        <li class="breadcrumb-item active"><spring:message code="attend.verif" /></li>
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
          <div class="card">
            <div class="card-header">
              <i class="fa fa-search"></i> <spring:message code="review" />
              <div class="card-actions">
              </div>
            </div>
            <div class="card-body">
              <table id="lista_solicitudes" class="table table-striped table-bordered datatable" width="100%">
                <thead>
                	<tr>
	                    <th><spring:message code="numSolicitud" /></th>
	                    <th><spring:message code="fecSolicitud" /></th>
	                    <th><spring:message code="ctrSolicitud" /></th>
	                    <th><spring:message code="estSolicitud" /></th>
	                    <th><spring:message code="tipoSolicitud" /></th>
	                    <th><spring:message code="fecRequerida" /></th>
	                    <th></th>
                	</tr>
                </thead>
                <tbody>
                	<c:forEach items="${solicitudes}" var="solicitud">
                		<tr>
                			<spring:url value="/sols/atender/verificar/{idSolicitud}/"  var="verificarSolUrl">
                                <spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
                            </spring:url>
                            <td><c:out value="${solicitud.numSolicitud}" /></td>
                            <td><c:out value="${solicitud.fecSolicitud}" /></td>
                            <td><c:out value="${solicitud.ctrSolicitud}" /></td>
                            <td><c:out value="${solicitud.estSolicitud}" /></td>
                            <td><c:out value="${solicitud.tipoSolicitud}" /></td>
                            <td><c:out value="${solicitud.fecRequerida}" /></td>
                            <td><a href="${fn:escapeXml(verificarSolUrl)}" title="<spring:message code="review" />" class="btn btn-outline-primary btn-sm"><i class="fa fa-search"></i></a></td>
                		</tr>
                	</c:forEach>
                </tbody>
              </table>
              
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
  <spring:url value="/resources/vendors/js/jquery.dataTables.min.js" var="dataTablesSc" />
  <script src="${dataTablesSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.bootstrap4.min.js" var="dataTablesBsSc" />
  <script src="${dataTablesBsSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.responsive.min.js" var="dataTablesResponsive" />
  <script src="${dataTablesResponsive}" type="text/javascript"></script>
  
  
  <!-- Custom scripts required by this view -->
  <script>
  	$(function(){
	  var tableSols = $('#lista_solicitudes').DataTable({
        "oLanguage": {
            "sUrl": "${dataTablesLang}"
        },
        "responsive": true
      });
	  $('.datatable').attr('style', 'border-collapse: collapse !important');      
	});    
  </script>
</body>
</html>