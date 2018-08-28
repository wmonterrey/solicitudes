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
        <li class="breadcrumb-item active"><spring:message code="accounts" /></li>
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
              <i class="fa fa-usd"></i> <spring:message code="accounts" />
              <div class="card-actions">
              </div>
            </div>
            <div class="card-body">
              <spring:url value="/admin/cuentas/newCuenta/"	var="newCuenta"/>	
              <button id="lista_cuentas_new" onclick="location.href='${fn:escapeXml(newCuenta)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-plus"></i>&nbsp; <spring:message code="add" /></button><br><br>	
              <table id="lista_cuentas" class="table table-striped table-bordered datatable" width="100%">
                <thead>
                	<tr>
	                    <th><spring:message code="idCuenta" /></th>
	                    <th class="hidden-xs"><spring:message code="nombreCuenta" /></th>
	                    <th><spring:message code="enabled" /></th>
						<th><spring:message code="addedBy" /></th>
						<th><spring:message code="dateAdded" /></th>
						<th><spring:message code="actions" /></th>
                	</tr>
                </thead>
                <tbody>
                	<c:forEach items="${cuentas}" var="cuenta">
                		<tr>
                			<spring:url value="/admin/cuentas/{cuenta}/"
                                        var="cuentaUrl">
                                <spring:param name="cuenta" value="${cuenta.idCuenta}" />
                            </spring:url>
                            <spring:url value="/admin/cuentas/editCuenta/{cuenta}/"
                                        var="editUrl">
                                <spring:param name="cuenta" value="${cuenta.idCuenta}" />
                            </spring:url>
                            <spring:url value="/admin/cuentas/desCuenta/{idCuenta}/" var="disableUrl"><spring:param name="idCuenta" value="${cuenta.idCuenta}" /></spring:url>
                            <spring:url value="/admin/cuentas/habCuenta/{idCuenta}/" var="enableUrl"><spring:param name="idCuenta" value="${cuenta.idCuenta}" /></spring:url>
                            <td><a href="${fn:escapeXml(cuentaUrl)}"><c:out value="${cuenta.idCuenta}" /></a></td>
                            <td class="hidden-xs"><c:out value="${cuenta.nombreCuenta}" /></td>
                            <c:choose>
								<c:when test="${cuenta.pasive=='0'.charAt(0)}">
									<td><span class="badge badge-success"><spring:message code="CAT_SINO_SI" /></span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge badge-danger"><spring:message code="CAT_SINO_NO" /></span></td>
								</c:otherwise>
							</c:choose>
							<td><c:out value="${cuenta.recordUser}" /></td>
							<td><c:out value="${cuenta.recordDate}" /></td>
                            <td>
                                <a href="${fn:escapeXml(cuentaUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-search"></i></a>
                                <a href="${fn:escapeXml(editUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-edit"></i></a>
                                <c:choose>
								<c:when test="${cuenta.pasive=='0'.charAt(0)}">
									<a href="#" data-toggle="modal" data-nomitem="${cuenta.nombreCuenta}" data-whatever="${fn:escapeXml(disableUrl)}" class="btn btn-outline-primary btn-sm desact"><i class="fa fa-trash-o"></i></a>
								</c:when>
								<c:otherwise>
									<a href="#" data-toggle="modal" data-nomitem="${cuenta.nombreCuenta}" data-whatever="${fn:escapeXml(enableUrl)}" class="btn btn-outline-primary btn-sm act"><i class="fa fa-check"></i></a>
								</c:otherwise>
							</c:choose>
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
    <!-- Modal -->
 	<div class="modal fade" id="basic" tabindex="-1" data-role="basic" data-backdrop="static" data-aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<div id="titulo"></div>
			</div>
			<div class="modal-body">
				<input type="hidden" id="accionUrl"/>
				<div id="cuerpo">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
				<button type="button" class="btn btn-info" onclick="ejecutarAccion()"><spring:message code="ok" /></button>
			</div>
		</div>
		<!-- /.modal-content -->
    </div>
  <!-- /.modal-dialog -->
 	  </div>
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
  <c:set var="cuentaEnabledLabel"><spring:message code="cuentaEnabled" /></c:set>
  <c:set var="cuentaDisabledLabel"><spring:message code="cuentaDisabled" /></c:set>
  <c:set var="habilitar"><spring:message code="enable" /></c:set>
  <c:set var="deshabilitar"><spring:message code="disable" /></c:set>
  <c:set var="confirmar"><spring:message code="confirm" /></c:set>
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

  	if ("${cuentaHabilitado}"){
		toastr.info("${cuentaEnabledLabel}", "${nombreCuenta}", {
		    closeButton: true,
		    progressBar: true,
		  } );
	}
	if ("${cuentaDeshabilitado}"){
		toastr.error("${cuentaDisabledLabel}", "${nombreCuenta}" , {
		    closeButton: true,
		    progressBar: true,
		  });
	}

	$(".act").click(function(){ 
		var nombreItem = $(this).data('nomitem');
		$('#accionUrl').val($(this).data('whatever'));
    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
    	$('#cuerpo').html('<h3>'+"${habilitar}"+' '+ nombreItem +'?</h3>');
    	$('#basic').modal('show');
    });
    
    $(".desact").click(function(){ 
    	var nombreItem = $(this).data('nomitem');
    	$('#accionUrl').val($(this).data('whatever'));
    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
    	$('#cuerpo').html('<h3>'+"${deshabilitar}"+ ' ' + nombreItem +'?</h3>');
    	$('#basic').modal('show');
    });

    function ejecutarAccion() {
		window.location.href = $('#accionUrl').val();		
	}
  </script>
</body>
</html>