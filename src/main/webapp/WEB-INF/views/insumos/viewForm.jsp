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
        <li class="breadcrumb-item"><a href="<spring:url value="/super/insumos/" htmlEscape="true "/>"><spring:message code="itemcat" /></a></li>
        <li class="breadcrumb-item active"><c:out value="${insumo.codigoBrand}" /></li>
        <!-- Breadcrumb Menu-->
        <li class="breadcrumb-menu d-md-down-none">
          <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <a class="btn" href="#"><i class="icon-speech"></i></a>
            <a class="btn" href="<spring:url value="/" htmlEscape="true "/>"><i class="icon-graph"></i>&nbsp;<spring:message code="dashboard" /></a>
            <a class="btn" href="<spring:url value="/logout" htmlEscape="true" />"><i class="icon-logout"></i>&nbsp;<spring:message code="logout" /></a>
          </div>
        </li>
      </ol>
      <spring:url value="/super/insumos/editInsumo/{idInsumo}/" var="editUrl">
		<spring:param name="idInsumo" value="${insumo.idInsumo}" />
	  </spring:url>
	  <spring:url value="/super/insumos/desInsumo/{idInsumo}/" var="disableUrl">
		<spring:param name="idInsumo" value="${insumo.idInsumo}" />
	  </spring:url>
	  <spring:url value="/super/insumos/habInsumo/{idInsumo}/" var="enableUrl">
		<spring:param name="idInsumo" value="${insumo.idInsumo}" />
	  </spring:url>
	  <!-- Container -->
      <div class="container-fluid">
      	<div class="animated fadeIn">

          	<div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header bg-dark text-white">
	                  <i class="icon-basket-loaded"></i>&nbsp;<strong><c:out value="${insumo.codigoBrand}" /></strong>
	                  <ul class="nav nav-tabs float-right">
						  <li class="nav-item dropdown">
						    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><i class="icon-settings">&nbsp;<spring:message code="actions" /></i></a>
						    <div class="dropdown-menu">
						    	<a class="dropdown-item" href="${fn:escapeXml(editUrl)}"><i class="fa fa-edit"></i> <spring:message code="edit" /></a>
						    	<c:choose>
									<c:when test="${insumo.pasive=='0'.charAt(0)}">
										<a href="#" class="dropdown-item desact" data-nomitem="${insumo.codigoBrand}" data-toggle="modal" data-whatever="${fn:escapeXml(disableUrl)}"><i class="fa fa-trash-o"></i> <spring:message code="disable" /></a>
									</c:when>
									<c:otherwise>
										<a href="#" class="dropdown-item act" data-nomitem="${insumo.codigoBrand}" data-toggle="modal" data-whatever="${fn:escapeXml(enableUrl)}"><i class="fa fa-check"></i> <spring:message code="enable" /></a>
									</c:otherwise>
								</c:choose>
						    </div>
						  </li>
						</ul>
	                </div>
	                	<div class="card-body">
		                	<form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
		                		<div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="idInsumo" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.idInsumo}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="nombreInsumoEn" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.nombreInsumoEn}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="nombreInsumoEs" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.nombreInsumoEs}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="codigoBrand" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.codigoBrand}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="casaBrand" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.casaBrand}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="codigoDistribuidor" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.codigoDistribuidor}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="casaDistribuidor" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.casaDistribuidor}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="codigoLocal" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.codigoLocal}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="tipoInsumo" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.tipoInsumo}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="undMedida" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.undMedida}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="nivelAdvertencia" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.nivelAdvertencia}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="enabled" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong>
			                        	<c:choose>
											<c:when test="${insumo.pasive=='0'.charAt(0)}">
												<strong><spring:message code="CAT_SINO_SI" /></strong>
											</c:when>
											<c:otherwise>
												<strong><spring:message code="CAT_SINO_NO" /></strong>
											</c:otherwise>
										</c:choose>
			                        </strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="createdBy" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.recordUser}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-3 col-form-label"><spring:message code="dateCreated" />:</label>
			                      <div class="col-md-9">
			                        <p class="form-control-static"><strong><c:out value="${insumo.recordDate}" /></strong></p>
			                      </div>
			                    </div>
		                	</form>
						</div>
					</div>
				</div>
	            <!--/.col-->
         	</div>
         	
            <div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header bg-dark text-white">
	                  <i class="icon-pencil"></i>&nbsp;<strong><spring:message code="audittrail" /></strong>
	                </div>
	                <div class="card-body">
	                	<table id="lista_cambios" class="table table-striped table-bordered datatable" width="100%">
			                <thead>
			                	<tr>
									<th><spring:message code="entityClass" /></th>
									<th><spring:message code="entityName" /></th>
									<th><spring:message code="entityProperty" /></th>
									<th><spring:message code="entityPropertyOldValue" /></th>
									<th><spring:message code="entityPropertyNewValue" /></th>
									<th><spring:message code="modifiedBy" /></th>
									<th><spring:message code="dateModified" /></th>
			                	</tr>
			                </thead>
			                <tbody>
							<c:forEach items="${bitacora}" var="cambio">
								<tr>
									<td><spring:message code="${cambio.entityClass}" /></td>
									<td><c:out value="${cambio.entityName}" /></td>
									<td><c:out value="${cambio.entityProperty}" /></td>
									<td><c:out value="${cambio.entityPropertyOldValue}" /></td>
									<td><c:out value="${cambio.entityPropertyNewValue}" /></td>
									<td><c:out value="${cambio.username}" /></td>
									<td><c:out value="${cambio.operationDate}" /></td>
								</tr>
							</c:forEach>
			                </tbody>
			            </table>
	                </div>
	              </div>
	            </div>
            </div>
		</div>
      </div>
      <!-- /.container-fluid -->
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
  <spring:url value="/resources/vendors/js/i18n/datatables/label_{language}.json" var="dataTablesLang">
  	<spring:param name="language" value="${lenguaje}" />
  </spring:url>
  <spring:url value="/resources/vendors/js/jquery.dataTables.min.js" var="dataTablesSc" />
  <script src="${dataTablesSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.bootstrap4.min.js" var="dataTablesBsSc" />
  <script src="${dataTablesBsSc}" type="text/javascript"></script>

  
  <c:set var="insumoEnabledLabel"><spring:message code="insumoEnabled" /></c:set>
  <c:set var="insumoDisabledLabel"><spring:message code="insumoDisabled" /></c:set>
  <c:set var="habilitar"><spring:message code="enable" /></c:set>
  <c:set var="deshabilitar"><spring:message code="disable" /></c:set>
  <c:set var="confirmar"><spring:message code="confirm" /></c:set>
		
  <script>
  
    $(function(){
	  $('.datatable').DataTable({
          "oLanguage": {
              "sUrl": "${dataTablesLang}"
          },
          "scrollX": true,
          "lengthMenu": [[5,10, 25, 50], [5,10, 25, 50]]
      });
	  $('.datatable').attr('style', 'border-collapse: collapse !important');
	});


    if ("${insumoHabilitado}"){
		toastr.info("${insumoEnabledLabel}", "${nombreInsumo}", {
		    closeButton: true,
		    progressBar: true,
		  } );
	}
	if ("${insumoDeshabilitado}"){
		toastr.error("${insumoDisabledLabel}", "${nombreInsumo}" , {
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