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
        <li class="breadcrumb-item"><a href="<spring:url value="/admin/centers/" htmlEscape="true "/>"><spring:message code="centers" /></a></li>
        <li class="breadcrumb-item active"><c:out value="${centro.nombreCentro}" /></li>
        <!-- Breadcrumb Menu-->
        <li class="breadcrumb-menu d-md-down-none">
          <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <a class="btn" href="#"><i class="icon-speech"></i></a>
            <a class="btn" href="<spring:url value="/" htmlEscape="true "/>"><i class="icon-graph"></i>&nbsp;<spring:message code="dashboard" /></a>
            <a class="btn" href="<spring:url value="/logout" htmlEscape="true" />"><i class="icon-logout"></i>&nbsp;<spring:message code="logout" /></a>
          </div>
        </li>
      </ol>
	  <!-- Container -->
      <div class="container-fluid">
      	<div class="animated fadeIn">
			<div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header bg-dark text-white">
	                  <i class="fa fa-building"></i>&nbsp;<strong><c:out value="${centro.nombreCentro}" /></strong>
	                </div>
                	<div class="card-body">
	                	<form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
	                		<div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="idCentro" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${centro.idCentro}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="enabled" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong>
		                        	<c:choose>
										<c:when test="${centro.pasive=='0'.charAt(0)}">
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
		                      <label class="col-md-3 col-form-label"><spring:message code="puedeComprar" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong>
		                        	<c:choose>
										<c:when test="${centro.puedeComprar=='1'}">
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
		                        <p class="form-control-static"><strong><c:out value="${centro.recordUser}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="dateCreated" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${centro.recordDate}" /></strong></p>
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
	                  <i class="fa fa-archive"></i>&nbsp;<strong><spring:message code="studies" /></strong>
	                </div>
	                <div class="card-body">
	                	<table id="lista_estudios" class="table table-striped table-bordered datatable" width="100%">
			                <thead>
			                	<tr>
				                    <th><spring:message code="studies" /></th>
									<th><spring:message code="enabled" /></th>
									<th><spring:message code="addedBy" /></th>
									<th><spring:message code="dateAdded" /></th>
									<th><spring:message code="actions" /></th>
			                	</tr>
			                </thead>
			                <tbody>
			                	<c:forEach items="${estudioscentros}" var="estudio">
								<tr>
									<spring:url value="/admin/centers/disableEstudio/{idCentro}/{idEstudio}/" var="disableEstudioUrl">
		                               <spring:param name="idEstudio" value="${estudio.estudio.idEstudio}" />
		                               <spring:param name="idCentro" value="${estudio.centro.idCentro}" />
		                            </spring:url>
		                            <spring:url value="/admin/centers/enableEstudio/{idCentro}/{idEstudio}/" var="enableEstudioUrl">
		                               <spring:param name="idEstudio" value="${estudio.estudio.idEstudio}" />
		                               <spring:param name="idCentro" value="${estudio.centro.idCentro}" />
		                            </spring:url>
									<td><c:out value="${estudio.estudio.nombreEstudio}" /></td>
									<c:choose>
										<c:when test="${estudio.pasive=='0'.charAt(0)}">
											<td><span class="badge badge-success"><spring:message code="CAT_SINO_SI" /></span></td>
										</c:when>
										<c:otherwise>
											<td><span class="badge badge-danger"><spring:message code="CAT_SINO_NO" /></span></td>
										</c:otherwise>
									</c:choose>
									<td><c:out value="${estudio.recordUser}" /></td>
									<td><c:out value="${estudio.recordDate}" /></td>
									<c:choose>
										<c:when test="${estudio.pasive=='0'.charAt(0)}">
											<td><a data-toggle="modal" data-nomitem="${estudio.estudio.nombreEstudio}" data-whatever="${fn:escapeXml(disableEstudioUrl)}" class="btn btn-outline-primary btn-sm desact"><i class="fa fa-trash-o"></i></a></td>
										</c:when>
										<c:otherwise>
											<td><a data-toggle="modal" data-nomitem="${estudio.estudio.nombreEstudio}" data-whatever="${fn:escapeXml(enableEstudioUrl)}" class="btn btn-outline-primary btn-sm act"><i class="fa fa-check"></i></a></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
			                </tbody>
			            </table>
	                </div>
	                <div class="card-header">
	                    <div class="row float-right mr-4" >
			            	<spring:url value="/admin/centers/addEstudio/{idCentro}/" var="addEstudioUrl"><spring:param name="idCentro" value="${centro.idCentro}" /></spring:url>
			            	<button type="button" class="btn btn-primary" id="addEstudio" data-toggle="modal" data-whatever="${fn:escapeXml(addEstudioUrl)}"><i class="fa fa-plus"></i>&nbsp;<spring:message code="add" /></button>
			            </div>
	                </div>
	              </div>
	            </div>
            </div>
            <div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header bg-dark text-white">
	                  <i class="fa fa-group"></i>&nbsp;<strong><spring:message code="users" /></strong>
	                </div>
	                <div class="card-body">
	                	<table id="lista_usuarios" class="table table-striped table-bordered datatable" width="100%">
			                <thead>
			                	<tr>
				                    <th><spring:message code="users" /></th>
									<th><spring:message code="enabled" /></th>
									<th><spring:message code="addedBy" /></th>
									<th><spring:message code="dateAdded" /></th>
									<th><spring:message code="actions" /></th>
			                	</tr>
			                </thead>
			                <tbody>
			                	<c:forEach items="${usuarioscentros}" var="usuario">
								<tr>
									<spring:url value="/admin/centers/disableUsuario/{idCentro}/{username}/" var="disableUsuarioUrl">
		                               <spring:param name="username" value="${usuario.userCenterId.username}" />
		                               <spring:param name="idCentro" value="${usuario.userCenterId.center}" />
		                            </spring:url>
		                            <spring:url value="/admin/centers/enableUsuario/{idCentro}/{username}/" var="enableUsuarioUrl">
		                               <spring:param name="username" value="${usuario.userCenterId.username}" />
		                               <spring:param name="idCentro" value="${usuario.userCenterId.center}" />
		                            </spring:url>
									<td><c:out value="${usuario.user.username}" /></td>
									<c:choose>
										<c:when test="${usuario.pasive=='0'.charAt(0)}">
											<td><span class="badge badge-success"><spring:message code="CAT_SINO_SI" /></span></td>
										</c:when>
										<c:otherwise>
											<td><span class="badge badge-danger"><spring:message code="CAT_SINO_NO" /></span></td>
										</c:otherwise>
									</c:choose>
									<td><c:out value="${usuario.recordUser}" /></td>
									<td><c:out value="${usuario.recordDate}" /></td>
									<c:choose>
										<c:when test="${usuario.pasive=='0'.charAt(0)}">
											<td><a data-toggle="modal" data-nomitem="${usuario.user.username}" data-whatever="${fn:escapeXml(disableUsuarioUrl)}" class="btn btn-outline-primary btn-sm desact"><i class="fa fa-trash-o"></i></a></td>
										</c:when>
										<c:otherwise>
											<td><a data-toggle="modal" data-nomitem="${usuario.user.username}" data-whatever="${fn:escapeXml(enableUsuarioUrl)}" class="btn btn-outline-primary btn-sm act"><i class="fa fa-check"></i></a></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
			                </tbody>
			            </table>
	                </div>
	                <div class="card-header">
	                    <div class="row float-right mr-4" >
			            	<spring:url value="/admin/centers/addUsuario/{idCentro}/" var="addUsuarioUrl"><spring:param name="idCentro" value="${centro.idCentro}" /></spring:url>
			            	<button type="button" class="btn btn-primary" id="addUsuario" data-toggle="modal" data-whatever="${fn:escapeXml(addUsuarioUrl)}"><i class="fa fa-plus"></i>&nbsp;<spring:message code="add" /></button>
			            </div>
	                </div>
	              </div>
	            </div>
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
  	  </div>
  	  <!-- Modal -->
  	  <div class="modal fade" id="estudiosForm" data-role="estudiosForm" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="modal-title"><spring:message code="add" /> <spring:message code="studies" /></h2>
				</div>
				<div class="modal-body">
					<input type="hidden" id="inputAddEstudioUrl"/>
					<div id="cuerpo">
						<fieldset class="form-group">
		                 	<i class="fa fa-check"></i>
		                    <label><spring:message code="studies" /></label>
		                    <select id="estudios" name="estudios" class="form-control select2-single">
		                      <c:forEach items="${estudios}" var="estudio">
		                      	<option value="${estudio.idEstudio}">${estudio.nombreEstudio}</option>
		                      </c:forEach>
		                    </select>
		                 </fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
					<button type="button" id="buttonAgregarEstudio" class="btn btn-info" onclick="ejecutarAgregarEstudio()"><spring:message code="ok" /></button>
				</div>
			</div>
			<!-- /.modal-content -->
	    </div>
	  </div>
	  <!-- /.modal-dialog -->
	  <!-- Modal -->
  	  <div class="modal fade" id="usuariosForm" data-role="usuariosForm" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="modal-title"><spring:message code="add" /> <spring:message code="users" /></h2>
				</div>
				<div class="modal-body">
					<input type="hidden" id="inputAddUsuarioUrl"/>
					<div id="cuerpo">
						<fieldset class="form-group">
		                 	<i class="fa fa-check"></i>
		                    <label><spring:message code="users" /></label>
		                    <select id="usuarios" name="usuarios" class="form-control select2-single">
		                      <c:forEach items="${usuarios}" var="usuario">
		                      	<option value="${usuario.username}">${usuario.completeName}</option>
		                      </c:forEach>
		                    </select>
		                 </fieldset>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
					<button type="button" id="buttonAgregarUsuario" class="btn btn-info" onclick="ejecutarAgregarUsuario()"><spring:message code="ok" /></button>
				</div>
			</div>
			<!-- /.modal-content -->
	    </div>
	  <!-- /.modal-dialog -->
  	  </div>
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
  <spring:url value="/resources/vendors/js/i18n/datatables/label_{language}.json" var="dataTablesLang">
  	<spring:param name="language" value="${lenguaje}" />
  </spring:url>
  <spring:url value="/resources/vendors/js/jquery.dataTables.min.js" var="dataTablesSc" />
  <script src="${dataTablesSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.bootstrap4.min.js" var="dataTablesBsSc" />
  <script src="${dataTablesBsSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/select2.min.js" var="Select2" />
  <script src="${Select2}" type="text/javascript"></script>
  <c:set var="successmessage"><spring:message code="process.success" /></c:set>
  <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
  <c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
  <c:set var="habilitar"><spring:message code="enable" /></c:set>
  <c:set var="agregar"><spring:message code="add" /></c:set>
  <c:set var="deshabilitar"><spring:message code="disable" /></c:set>
  <c:set var="confirmar"><spring:message code="confirm" /></c:set> 
  
  <c:set var="estudioEnabledLabel"><spring:message code="estudioEnabled" /></c:set>
  <c:set var="estudioDisabledLabel"><spring:message code="estudioDisabled" /></c:set>
  <c:set var="estudioAddedLabel"><spring:message code="estudioAdded" /></c:set>
  <c:set var="allEstudiosLabel"><spring:message code="estudioAll" /></c:set> 
  
  <c:set var="usuarioEnabledLabel"><spring:message code="usuarioEnabled" /></c:set>
  <c:set var="usuarioDisabledLabel"><spring:message code="usuarioDisabled" /></c:set>
  <c:set var="usuarioAddedLabel"><spring:message code="usuarioAdded" /></c:set>
  <c:set var="allUsuariosLabel"><spring:message code="usuarioAll" /></c:set> 
		
  
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

	if ("${estudioHabilitado}"){
		toastr.info("${estudioEnabledLabel}", "${nombreEstudio}", {
		    closeButton: true,
		    progressBar: true,
		  } );
	}
	if ("${estudioDeshabilitado}"){
		toastr.error("${estudioDisabledLabel}", "${nombreEstudio}" , {
		    closeButton: true,
		    progressBar: true,
		  });
	}

	if ("${estudioAgregado}"){
		toastr.info("${estudioAddedLabel}", "${nombreEstudio}" , {
		    closeButton: true,
		    progressBar: true,
		  });
	}

	$("#addEstudio").click(function(){ 
		$('#inputAddEstudioUrl').val($(this).data('whatever'));
		if($('#estudios').val()) {
			$('#estudiosForm').modal('show');
		}
		else{
			toastr.info("${allEstudiosLabel}", "" ,{
			    closeButton: true,
			    progressBar: true,
			  } );
		}
    });

	$('#estudiosForm').on('shown.bs.modal', function () {
        $('#estudios').select2({
        	dropdownParent: $("#estudiosForm"),
        	theme: "bootstrap"
    	});
    })
    
    function ejecutarAgregarEstudio() {
		window.location.href = $('#inputAddEstudioUrl').val()+$('#estudios').val()+'/';		
	}

	if ("${usuarioHabilitado}"){
		toastr.info("${usuarioEnabledLabel}", "${nombreUsuario}", {
		    closeButton: true,
		    progressBar: true,
		  } );
	}
	if ("${usuarioDeshabilitado}"){
		toastr.error("${usuarioDisabledLabel}", "${nombreUsuario}" , {
		    closeButton: true,
		    progressBar: true,
		  });
	}

	if ("${usuarioAgregado}"){
		toastr.info("${usuarioAddedLabel}", "${nombreUsuario}" , {
		    closeButton: true,
		    progressBar: true,
		  });
	}

	$("#addUsuario").click(function(){ 
		$('#inputAddUsuarioUrl').val($(this).data('whatever'));
		if($('#usuarios').val()) {
			$('#usuariosForm').modal('show');
		}
		else{
			toastr.info("${allUsuariosLabel}", "" ,{
			    closeButton: true,
			    progressBar: true,
			  } );
		}
    });

	$('#usuariosForm').on('shown.bs.modal', function () {
        $('#usuarios').select2({
        	dropdownParent: $("#usuariosForm"),
        	theme: "bootstrap"
    	});
    })
    
    function ejecutarAgregarUsuario() {
		window.location.href = $('#inputAddUsuarioUrl').val()+$('#usuarios').val()+'/';		
	}
    
	
  </script>
</body>
</html>