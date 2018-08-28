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
<spring:url value="/resources/vendors/css/dataTables.bootstrap4.min.css" var="dataTablesCSS" />
<link href="${dataTablesCSS}" rel="stylesheet" type="text/css"/>
<spring:url value="/resources/vendors/css/responsive.dataTables.min.css" var="dataTablesResponsiveCSS" />
<link href="${dataTablesResponsiveCSS}" rel="stylesheet" type="text/css"/>

<spring:url value="/resources/vendors/css/select.dataTables.min.css" var="dataTablesSelectCSS" />
<link href="${dataTablesSelectCSS}" rel="stylesheet" type="text/css"/>

<spring:url value="/resources/vendors/css/buttons.dataTables.min.css" var="dataTablesButtonCSS" />
<link href="${dataTablesButtonCSS}" rel="stylesheet" type="text/css"/>

<style type="text/css" class="init">


</style>
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
        <li class="breadcrumb-item"><a href="<spring:url value="/sols/aprobar/" htmlEscape="true "/>"><spring:message code="sols.aprob" /></a></li>
        <li class="breadcrumb-item active"><c:out value="${solicitud.numSolicitud}" /></li>
        <!-- Breadcrumb Menu-->
        <li class="breadcrumb-menu d-md-down-none">
          <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
            <a class="btn" href="#"><i class="icon-speech"></i></a>
            <a class="btn" href="<spring:url value="/" htmlEscape="true "/>"><i class="icon-graph"></i>&nbsp;<spring:message code="dashboard" /></a>
            <a class="btn" href="<spring:url value="/logout" htmlEscape="true" />"><i class="icon-logout"></i>&nbsp;<spring:message code="logout" /></a>
          </div>
        </li>
      </ol>
      
      <spring:url value="/sols/aprobar/{idSolicitud}/" var="solUrl">
		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
      
      <spring:url value="/sols/aprobar/sendSolicitudAut/{idSolicitud}/" var="sendAutUrl">
		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
	  
	  <spring:url value="/sols/aprobar/deleteSolicitud/{idSolicitud}/" var="deleteSolUrl">
		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
	  
	  <spring:url value="/sols/aprobar/finalizeSolicitud/{idSolicitud}/" var="finalizeSolUrl">
		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
	  
	  <!-- Container -->
      <div class="container-fluid">
      	<div class="animated fadeIn">

          	<div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header bg-dark text-white">
	                  <i class="icon-check"></i>&nbsp;<spring:message code="numSolicitud" />:&nbsp;<strong><c:out value="${solicitud.numSolicitud}" /></strong>
	                  <c:if test = "${editable}">
	                  <ul class="nav nav-tabs float-right">
						  <li class="nav-item dropdown">
						    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><i class="icon-settings">&nbsp;<spring:message code="actions" /></i></a>
						    <div class="dropdown-menu">
						    	<c:if test = "${aprCompleto && algunoAprob}">
						    		<a href="#" class="dropdown-item autorizar" data-nomitem="${solicitud.numSolicitud}" data-toggle="modal" data-whatever="${fn:escapeXml(sendAutUrl)}"><i class="fa fa-check"></i> <spring:message code="sentAut" /></a>
						    	</c:if>
						    	<c:if test = "${aprCompleto && not algunoAprob}">
						    		<a href="#" class="dropdown-item finalizar" data-nomitem="${solicitud.numSolicitud}" data-toggle="modal" data-whatever="${fn:escapeXml(finalizeSolUrl)}"><i class="fa fa-pencil-square"></i> <spring:message code="end" /></a>
						    		<a href="#" class="dropdown-item eliminar" data-nomitem="${solicitud.numSolicitud}" data-toggle="modal" data-whatever="${fn:escapeXml(deleteSolUrl)}"><i class="fa fa-trash"></i> <spring:message code="delete" /></a>
						    	</c:if>
						    </div>
						  </li>
						</ul>
						</c:if>
	                </div>
	                	<div class="card-body">
		                	<form action="" method="post" enctype="multipart/form-data" class="form-horizontal">
		                		<div class="form-group row">
			                      <label class="col-md-2 col-form-label"><spring:message code="idSolicitud" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.idSolicitud}" /></strong></p>
			                      </div>
			                      <label class="col-md-2 col-form-label"><spring:message code="fecSolicitud" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.fecSolicitud}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-2 col-form-label"><spring:message code="ctrSolicitud" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.ctrSolicitud}" /></strong></p>
			                      </div>
			                      <label class="col-md-2 col-form-label"><spring:message code="usrSolicitud" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.usrSolicitud}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-2 col-form-label"><spring:message code="tipoSolicitud" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.tipoSolicitud}" /></strong></p>
			                      </div>
			                      <label class="col-md-2 col-form-label"><spring:message code="estSolicitud" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.estSolicitud}" /></strong></p>
			                      </div>
			                    </div>
			                    
			                    <div class="form-group row">
			                      <label class="col-md-2 col-form-label"><spring:message code="fecRequerida" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.fecRequerida}" /></strong></p>
			                      </div>
			                      <label class="col-md-2 col-form-label"><spring:message code="fecAtendida" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.fecAtendida}" /></strong></p>
			                      </div>
			                    </div>
			                    <div class="form-group row">
			                      <label class="col-md-2 col-form-label"><spring:message code="observaciones" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.observaciones}" /></strong></p>
			                      </div>
			                      <label class="col-md-2 col-form-label"><spring:message code="enabled" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong>
			                        	<c:choose>
											<c:when test="${solicitud.pasive=='0'.charAt(0)}">
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
			                      <label class="col-md-2 col-form-label"><spring:message code="createdBy" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.recordUser}" /></strong></p>
			                      </div>
			                      <label class="col-md-2 col-form-label"><spring:message code="dateCreated" />:</label>
			                      <div class="col-md-4">
			                        <p class="form-control-static"><strong><c:out value="${solicitud.recordDate}" /></strong></p>
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
	                <div class="card-header bg-secondary">
	                  <i class="icon-basket-loaded"></i>&nbsp;<strong><spring:message code="itemcat" /></strong>
	                </div>
	                <div class="card-body">
	                	<table id="lista_insumos" class="table table-striped table-bordered" width="100%">
			                <thead>
			                	<tr>
				                    <th><spring:message code="codigoBrand" /></th>
			                    	<th><spring:message code="insumo" /></th>
			                    	<th><spring:message code="estItem" /></th>
			                    	<th><spring:message code="usrSolicitaItem" /></th>
			                    	<th><spring:message code="ctrCompra" /></th>
			                    	<th><spring:message code="cantSolicitada" /></th>
			                    	<th><spring:message code="undMedida" /></th>
			                    	<th><spring:message code="presentacion" /></th>
			                    	<th><spring:message code="contenidoPresentacion" /></th>
			                    	<th><spring:message code="totalProducto" /></th>
			                    	<th><spring:message code="aprobado" /></th>
			                    	<th><spring:message code="cantAprobada" /></th>
			                    	<th><spring:message code="usrApruebaItem" /></th>
			                    	<th><spring:message code="fechaAprobado" /></th>
			                    	<th><spring:message code="autorizado" /></th>
			                    	<th><spring:message code="cantAutorizada" /></th>
			                    	<th><spring:message code="usrAutorizaItem" /></th>
			                    	<th><spring:message code="fechaAutorizado" /></th>
			                    	<th><spring:message code="observacionesItem" /></th>
			                    	<th><spring:message code="motivoCancelada" /></th>
			                    	<th><spring:message code="pasivo" /></th>
				                    <th><spring:message code="createdBy" /></th>
				                    <th><spring:message code="dateCreated" /></th>
				                    <th><spring:message code="idItem" /></th>
									<th></th>
			                	</tr>
			                </thead>
			                <tbody>
		                		<c:forEach items="${items}" var="item">
									<tr>
										<spring:url value="/sols/aprobar/aprobItem/{idItem}/" var="aprobItemUrl">
			                                <spring:param name="idItem" value="${item.idItem}" />
			                            </spring:url>
			                            <spring:url value="/sols/aprobar/noAprobItem/{idItem}/" var="noAprobItemUrl">
			                                <spring:param name="idItem" value="${item.idItem}" />
			                            </spring:url>
										<td><c:out value="${item.insumo.codigoBrand}" /></td>
										<c:choose>
											<c:when test="${cookie.eSolicitudesLang.value == 'en'}">
												<td><c:out value="${item.insumo.nombreInsumoEn}" /></td>
											</c:when>
											<c:otherwise>
												<td><c:out value="${item.insumo.nombreInsumoEs}" /></td>
											</c:otherwise>
									  	</c:choose>
									  	<td><c:out value="${item.estItem}" /></td>
									  	<td><c:out value="${item.usrSolicitaItem}" /></td>
									  	<td><c:out value="${item.ctrCompra}" /></td>
									  	<td><c:out value="${item.cantSolicitada}" /></td>
									  	<td><c:out value="${item.insumo.undMedida}" /></td>
									  	<td><c:out value="${item.presentacion}" /></td>
									  	<td><c:out value="${item.contenidoPresentacion}" /></td>
									  	<td><c:out value="${item.totalProducto}" /></td>
									  	<td><c:out value="${item.aprobado}" /></td>
									  	<td><c:out value="${item.cantAprobada}" /></td>
									  	<td><c:out value="${item.usrApruebaItem}" /></td>
									  	<td><c:out value="${item.fechaAprobado}" /></td>
									  	<td><c:out value="${item.autorizado}" /></td>
									  	<td><c:out value="${item.cantAutorizada}" /></td>
									  	<td><c:out value="${item.usrAutorizaItem}" /></td>
									  	<td><c:out value="${item.fechaAutorizado}" /></td>
									  	<td><c:out value="${item.observaciones}" /></td>
									  	<td><c:out value="${item.motivono}" /></td>
									  	<td><c:out value="${item.pasive}" /></td>
									  	<td><c:out value="${item.recordUser}" /></td>
									  	<td><c:out value="${item.recordDate}" /></td>
									  	<td><c:out value="${item.idItem}" /></td>
										<td>
											<c:if test = "${editable}">
												<a href="${fn:escapeXml(aprobItemUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-edit"></i></a>
												<a href="#" data-toggle="modal" data-nomitem="${item.insumo.codigoBrand}" data-whatever="${fn:escapeXml(noAprobItemUrl)}" class="btn btn-outline-primary btn-sm delete-smt-btn"><i class="fa fa-close"></i></a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
			                </tbody>
			            </table>
	                </div>
	                <div class="card-header">
	                    <div class="row ml-4" >
	                    	<c:if test = "${editable}">
			            		<button id="items_aprob" disabled data-toggle="modal" data-target="#modalApprove" type="button" class="btn btn-outline-primary"><i class="fa fa-check"></i>&nbsp; <spring:message code="approve" /></button>&nbsp;&nbsp;&nbsp;&nbsp;
			            		<button id="items_no_aprob" disabled data-toggle="modal" data-target="#modalNotApprove" type="button" class="btn btn-outline-primary"><i class="fa fa-close"></i>&nbsp; <spring:message code="notapprove" /></button>
			            	</c:if>
			            </div>
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
					<form  id="motivoform">   
						<div class="form-group row">
	                      <div class="col-md-12">
	                      	<div class="input-group">
	                        	<input type="text" id="motivoCancelado" class="form-control" placeholder="<spring:message code="motivoCancelada"/>"/>
	                        </div>
	                      </div>
	                    </div>
					</form>
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
  	  <div class="modal fade" id="modalApprove" tabindex="-1" data-role="modalApprove" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div id="titulo"><h3><spring:message code="confirm" /></h3></div>
				</div>
				<div class="modal-body">
					<div id="cuerpo"><h4><spring:message code="approve" />&nbsp;<spring:message code="selected" />?</h4></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
					<button type="button" class="btn btn-info" onclick="ejecutarAprobacionLote(true)"><spring:message code="ok" /></button>
				</div>
			</div>
			<!-- /.modal-content -->
	    </div>
	  <!-- /.modal-dialog -->
	  </div>
	  <!-- Modal -->
  	  <div class="modal fade" id="modalNotApprove" tabindex="-1" data-role="modalNotApprove" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div id="titulo"><h3><spring:message code="confirm" /></h3></div>
				</div>
				<div class="modal-body">
					<div id="cuerpo"><h4><spring:message code="notapprove" />&nbsp;<spring:message code="selected" />?</h4></div>
					<form  id="motivoformLote">   
						<div class="form-group row">
	                      <div class="col-md-12">
	                      	<div class="input-group">
	                        	<input type="text" id="motivoCanceladoLote" class="form-control" placeholder="<spring:message code="motivoCancelada"/>"/>
	                        </div>
	                      </div>
	                    </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
					<button type="button" class="btn btn-info" onclick="ejecutarAprobacionLote(false)"><spring:message code="ok" /></button>
				</div>
			</div>
			<!-- /.modal-content -->
	    </div>
	  <!-- /.modal-dialog -->
	  </div>
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
  <spring:url value="/resources/vendors/js/dataTables.responsive.min.js" var="dataTablesResponsive" />
  <script src="${dataTablesResponsive}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.select.min.js" var="dataTablesSelect" />
  <script src="${dataTablesSelect}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.buttons.min.js" var="dataTablesButtons" />
  <script src="${dataTablesButtons}" type="text/javascript"></script>
 

  
  <c:set var="solicitudDisabledLabel"><spring:message code="solicitudDisabled" /></c:set>
  <c:set var="solicitudFinalizedLabel"><spring:message code="CAT_EST_SOL_7" /></c:set>
  <c:set var="confirmar"><spring:message code="confirm" /></c:set>
  <c:set var="sentAut"><spring:message code="sentAut" /></c:set>
  <c:set var="notUndo"><spring:message code="notUndo" /></c:set>
  <c:set var="deshabilitar"><spring:message code="disable" /></c:set>
  <c:set var="finalizar"><spring:message code="end" /></c:set>
  <c:set var="notapprove"><spring:message code="notapprove" /></c:set>
  <c:set var="itemNotApproved"><spring:message code="itemNotApproved" /></c:set>
  <c:set var="solSentAut"><spring:message code="solSentAut" /></c:set>
  
  <c:set var="successmessage"><spring:message code="process.success" /></c:set>
  <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
  <c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
  
  <c:set var="motivoCanceladaValidate"><spring:message code="motivoCanceladaValidate" /></c:set>
  	
  <spring:url value="/sols/aprobar/aprobarItems/" var="aprobarItemsUrl"></spring:url>
  <spring:url value="/sols/aprobar/noAprobarItems/" var="noAprobarItemsUrl"></spring:url>
  
  
  <script>


	  var table = $('#lista_insumos').DataTable({
		  dom: 'lBfrtip',
          "oLanguage": {
              "sUrl": "${dataTablesLang}"
          },
          "lengthMenu": [[5,10, 25, 50], [5,10, 25, 50]],
          "responsive": true,
          "select": true,
          "buttons": [
              'selectAll',
              'selectNone'
          ],
      });

	  table
      .on( 'select', function ( e, dt, type, indexes ) {
    	  var count = table.rows( { selected: true } ).count();
    	  count>0?$('#items_aprob').prop('disabled', false):$('#items_aprob').prop('disabled', true);
    	  count>0?$('#items_no_aprob').prop('disabled', false):$('#items_no_aprob').prop('disabled', true);
      } )
      .on( 'deselect', function ( e, dt, type, indexes ) {
    	  var count = table.rows( { selected: true } ).count();
    	  count>0?$('#items_aprob').prop('disabled', false):$('#items_aprob').prop('disabled', true);
    	  count>0?$('#items_no_aprob').prop('disabled', false):$('#items_no_aprob').prop('disabled', true);
      } );

	  function ejecutarAprobacionLote(aprobar) {
	    	var dataSelected = table.rows( { selected: true } ).data();
	    	var itemsSeleccionados = "";
	    	var urlAccion="";
	    	if(!aprobar && $('#motivoCanceladoLote').val()===""){
	        	alert("${motivoCanceladaValidate}"); 
	        }
	    	else{
		    	aprobar?urlAccion="${aprobarItemsUrl}":urlAccion="${noAprobarItemsUrl}";
		        for (var i=0; i < dataSelected.length ;i++){
		        	itemsSeleccionados=="" ? itemsSeleccionados = dataSelected[i][23] : itemsSeleccionados = itemsSeleccionados + "," + dataSelected[i][23];
		        }		
		        $.blockUI({ message: "${waitmessage}" });
			    $.post( urlAccion
			            , {seleccionados:itemsSeleccionados,motivo:$('#motivoCanceladoLote').val()}
			            , function( data )
			            {
			    			resultado = JSON.parse(data);
			    			if (resultado != "success") {
			    				toastr.error(data, "${errormessage}", {
			    					    closeButton: true,
			    					    progressBar: true,
			    					  });
			    				$.unblockUI();
							}
							else{
								$.blockUI({ message: "${successmessage}" });
								setTimeout(function() { 
						            $.unblockUI({ 
						                onUnblock: function(){ window.location.href = "${solUrl}"; } 
						            }); 
						        }, 1000); 
							}
			            }
			            , 'text' )
				  		.fail(function(XMLHttpRequest, textStatus, errorThrown) {
				    		alert( "error:" + errorThrown);
				    		$.unblockUI();
				  		});
	    	}
	  }

	  $(".autorizar").click(function(){ 
		    $('#motivoCancelado').val("");
	    	$('#motivoCancelado').hide();
			var nombreItem = $(this).data('nomitem');
			$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${sentAut}"+' '+ nombreItem +'?</h3></br><h4>'+"${notUndo}"+'</h4>');
	    	$('#basic').modal('show');
	    });

	  $(".eliminar").click(function(){ 
		    $('#motivoCancelado').val("");
	    	$('#motivoCancelado').show();
			var nombreItem = $(this).data('nomitem');
			$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${deshabilitar}"+' '+ nombreItem +'?</h3></br><h4>'+"${notUndo}"+'</h4>');
	    	$('#basic').modal('show');
	    });

	  $(".finalizar").click(function(){ 
		    $('#motivoCancelado').val("");
	    	$('#motivoCancelado').hide();
			var nombreItem = $(this).data('nomitem');
			$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${finalizar}"+' '+ nombreItem +'?</h3></br><h4>'+"${notUndo}"+'</h4>');
	    	$('#basic').modal('show');
	    });	    

	  $('#lista_insumos').on('click', '.delete-smt-btn', function(e){
	    	$('#motivoCancelado').val("");
	    	$('#motivoCancelado').show();
	        var nombreItem = $(this).data('nomitem');
	    	$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${notapprove}"+ ' ' + nombreItem +'?</h3>');
	    	$('#basic').modal('show');
	    });  


	  if ("${itemNoAprobado}"){
			toastr.error("${itemNotApproved}", "${nombreItem}" , {
			    closeButton: true,
			    progressBar: true,
			  });
		}  

	  if ("${solicitudDeshabilitada}"){
			toastr.error("${solicitudDisabledLabel}", "${nombreSolicitud}" , {
			    closeButton: true,
			    progressBar: true,
			  });
		}

	  if ("${solicitudFinalizada}"){
			toastr.info("${solicitudFinalizedLabel}", "${nombreSolicitud}" , {
			    closeButton: true,
			    progressBar: true,
			  });
		}

	  if ("${solicitudSent}"){
			toastr.info("${solSentAut}", "${nombreSolicitud}", {
			    closeButton: true,
			    progressBar: true,
			  } );
		}
		
	    function ejecutarAccion() {
	        if($('#motivoCancelado').is(':visible') && $('#motivoCancelado').val()===""){
	        	alert("${motivoCanceladaValidate}"); 
	        }
	        else if($('#motivoCancelado').is(':visible')){
	        	$('#accionUrl').val($('#accionUrl').val()+$('#motivoCancelado').val()+'/');
	        	window.location.href = $('#accionUrl').val();   
	        }	
	        else{
	        	window.location.href = $('#accionUrl').val();
	        }
	        					
		}
	
  </script>
</body>
</html>