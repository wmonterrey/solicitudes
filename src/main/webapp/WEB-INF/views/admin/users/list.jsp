<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../../fragments/headTag.jsp" />
<!-- Styles required by this views -->
<spring:url value="/resources/vendors/css/dataTables.bootstrap4.min.css" var="dataTablesCSS" />
<link href="${dataTablesCSS}" rel="stylesheet" type="text/css"/>

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

      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item active"><spring:message code="users" /></li>
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
              <i class="icon-people"></i> <spring:message code="users" />
              <div class="card-actions">
              </div>
            </div>
            <div class="card-body">
              <spring:url value="/admin/users/newUser/"	var="newUser"/>	
              <button id="lista_usuarios_new" onclick="location.href='${fn:escapeXml(newUser)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-plus"></i>&nbsp; <spring:message code="add" /></button><br><br>	
              <table id="lista_usuarios" class="table table-striped table-bordered datatable" width="100%">
                <thead>
                	<tr>
	                    <th><spring:message code="username" /></th>
	                    <th class="hidden-xs"><spring:message code="userdesc" /></th>
	                    <th class="hidden-xs"><spring:message code="useremail" /></th>
	                    <th><spring:message code="enabled" /></th>
	                    <th><spring:message code="userlock" /></th>
	                    <th><spring:message code="usercred" /></th>
	                    <th><spring:message code="actions" /></th>
                	</tr>
                </thead>
                <tbody>
                	<c:forEach items="${usuarios}" var="usuario">
                		<tr>
                			<spring:url value="/admin/users/{username}/"
                                        var="usuarioUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <spring:url value="/admin/users/editUser/{username}/"
                                        var="editUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <spring:url value="/admin/users/habdes/disable1/{username}/"
                                        var="disableUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <spring:url value="/admin/users/habdes/enable1/{username}/"
                                        var="enableUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <spring:url value="/admin/users/lockunl/lock1/{username}/"
                                        var="lockUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <spring:url value="/admin/users/lockunl/unlock1/{username}/"
                                        var="unlockUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <spring:url value="/admin/users/chgpass/{username}/"
                                        var="chgpassUrl">
                                <spring:param name="username" value="${usuario.username}" />
                            </spring:url>
                            <td><a href="${fn:escapeXml(usuarioUrl)}"><c:out value="${usuario.username}" /></a></td>
                            <td class="hidden-xs"><c:out value="${usuario.completeName}" /></td>
                            <td class="hidden-xs"><c:out value="${usuario.email}" /></td>
                            <c:choose>
                                <c:when test="${usuario.enabled}">
                                    <td><span class="badge badge-success"><spring:message code="CAT_SINO_SI" /></span></td>
                                </c:when>
                                <c:otherwise>
                                    <td><span class="badge badge-danger"><spring:message code="CAT_SINO_NO" /></span></td>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${usuario.accountNonLocked}">
                                    <td><span class="badge badge-success"><spring:message code="CAT_SINO_NO" /></span></td>
                                </c:when>
                                <c:otherwise>
                                    <td><span class="badge badge-danger"><spring:message code="CAT_SINO_SI" /></span></td>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${usuario.credentialsNonExpired}">
                                    <td><span class="badge badge-success"><spring:message code="CAT_SINO_NO" /></span></td>
                                </c:when>
                                <c:otherwise>
                                    <td><span class="badge badge-danger"><spring:message code="CAT_SINO_SI" /></span></td>
                                </c:otherwise>
                            </c:choose>
                            <td>
                                <a href="${fn:escapeXml(usuarioUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-search"></i></a>
                                <a href="${fn:escapeXml(editUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-edit"></i></a>
                                <a href="${fn:escapeXml(chgpassUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-key"></i></a>
                            </td>
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
  <spring:url value="/resources/vendors/js/i18n/datatables/label_{language}.json" var="dataTablesLang">
  	<spring:param name="language" value="${lenguaje}" />
  </spring:url>
  
  <!-- Plugins and scripts required by this views -->
  <spring:url value="/resources/vendors/js/jquery.dataTables.min.js" var="dataTablesSc" />
  <script src="${dataTablesSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.bootstrap4.min.js" var="dataTablesBsSc" />
  <script src="${dataTablesBsSc}" type="text/javascript"></script>
  
  <!-- Custom scripts required by this view -->
  <script>
  	$(function(){
	  $('.datatable').DataTable({
          "oLanguage": {
              "sUrl": "${dataTablesLang}"
          },
          "scrollX": true
      });
	  $('.datatable').attr('style', 'border-collapse: collapse !important');
	});
  </script>
</body>
</html>