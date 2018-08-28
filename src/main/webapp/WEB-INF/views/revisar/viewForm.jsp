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
        <li class="breadcrumb-item"><a href="<spring:url value="/sols/atender/verificar/" htmlEscape="true "/>"><spring:message code="attend.verif" /></a></li>
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
      
      <spring:url value="/sols/atender/verificar/{idSolicitud}/" var="solUrl">
		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
      
      <spring:url value="/sols/atender/verificar/finalizarRevision/{idSolicitud}/" var="finalizeReviewUrl">
		<spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	  </spring:url>
	  
	  <!-- Container -->
      <div class="container-fluid">
      	<div class="animated fadeIn">

          	<div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header bg-dark text-white">
	                  <i class="icon-magnifier-add"></i>&nbsp;<spring:message code="numSolicitud" />:&nbsp;<strong><c:out value="${solicitud.numSolicitud}" /></strong>
	                    <ul class="nav nav-tabs float-right">
						  <li class="nav-item dropdown">
						    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><i class="icon-settings">&nbsp;<spring:message code="actions" /></i></a>
						    <div class="dropdown-menu">
						    	<c:if test = "${revCompleto}">
						    		<a href="#" class="dropdown-item finalizar" data-nomitem="${solicitud.numSolicitud}" data-toggle="modal" data-whatever="${fn:escapeXml(finalizeReviewUrl)}"><i class="fa fa-check"></i> <spring:message code="finalizeReview" /></a>
						    	</c:if>
						    </div>
						  </li>
						</ul>
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
						          	<th><spring:message code="cantAutorizada" /></th>
						          	<th><spring:message code="undMedida" /></th>
						          	<th><spring:message code="presentacion" /></th>
						          	<th><spring:message code="contenidoPresentacion" /></th>
						          	<th><spring:message code="totalProducto" /></th>
						          	<th><spring:message code="observacionesItem" /></th>
						          	<th><spring:message code="estItem" /></th>
						          	<th><spring:message code="idItem" /></th>
						          	<th><spring:message code="idItem" /></th>
						          	<th><spring:message code="actions" /></th>
			                	</tr>
			                </thead>
			                <tbody>
		                		<c:forEach items="${items}" var="item">
									<tr>
										<spring:url value="/sols/atender/verificar/items/compra/{idItem}/" var="compraItemUrl">
			                                <spring:param name="idItem" value="${item.item.idItem}" />
			                            </spring:url>
			                            <spring:url value="/sols/atender/verificar/items/entrega/{idItem}/" var="entregaItemUrl">
			                                <spring:param name="idItem" value="${item.item.idItem}" />
			                            </spring:url>
			                            <spring:url value="/sols/atender/verificar/items/cancelar/{idItem}/" var="cancelaItemUrl">
			                                <spring:param name="idItem" value="${item.item.idItem}" />
			                            </spring:url>
										<td><c:out value="${item.item.insumo.codigoBrand}" /></td>
										<c:choose>
											<c:when test="${cookie.eSolicitudesLang.value == 'en'}">
												<td><c:out value="${item.item.insumo.nombreInsumoEn}" /></td>
											</c:when>
											<c:otherwise>
												<td><c:out value="${item.item.insumo.nombreInsumoEs}" /></td>
											</c:otherwise>
									  	</c:choose>
									  	<td><c:out value="${item.item.cantAutorizada}" /></td>
									  	<td><c:out value="${item.item.insumo.undMedida}" /></td>
									  	<td><c:out value="${item.item.presentacion}" /></td>
									  	<td><c:out value="${item.item.contenidoPresentacion}" /></td>
									  	<td><c:out value="${item.item.totalProducto}" /></td>
									  	<td><c:out value="${item.item.observaciones}" /></td>
									  	<td><c:out value="${item.item.estItem}" /></td>
									  	<td><c:out value="${item.item.idItem}" /></td>
									  	<td><c:out value="${item.entregado}" /></td>
										<td>	
											<c:if test = "${not item.entregado}">										
												<a href="#" data-toggle="modal" title="<spring:message code="sendCompra" />" data-nomitem="${item.item.insumo.codigoBrand}" data-whatever="${fn:escapeXml(compraItemUrl)}" class="btn btn-outline-primary btn-sm comprar"><i class="fa fa-shopping-basket"></i></a>
												<a href="#" data-toggle="modal" title="<spring:message code="sendDeliver" />" data-nomitem="${item.item.insumo.codigoBrand}" data-whatever="${fn:escapeXml(entregaItemUrl)}" class="btn btn-outline-primary btn-sm entregar"><i class="fa fa-download"></i></a>
												<a href="#" data-toggle="modal" title="<spring:message code="cancel" />" data-nomitem="${item.item.insumo.codigoBrand}" data-whatever="${fn:escapeXml(cancelaItemUrl)}" class="btn btn-outline-primary btn-sm cancelar"><i class="fa fa-close"></i></a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
			                </tbody>
			            </table>
	                </div>
	                <div class="card-header">
	                    <div class="row ml-4" >
			            	<button id="items_compra" disabled data-toggle="modal" data-target="#modalCompra" type="button" class="btn btn-outline-primary"><i class="fa fa-shopping-basket"></i>&nbsp; <spring:message code="sendCompra" /></button>&nbsp;&nbsp;&nbsp;&nbsp;
			            	<button id="items_entrega" disabled data-toggle="modal" data-target="#modalEntrega" type="button" class="btn btn-outline-primary"><i class="fa fa-download"></i>&nbsp; <spring:message code="sendDeliver" /></button>
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
	  </div>		    
	  <!-- /.modal-dialog -->
	  <!-- Modal -->
  	  <div class="modal fade" id="modalCompra" tabindex="-1" data-role="modalCompra" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div id="titulo"><h3><spring:message code="confirm" /></h3></div>
				</div>
				<div class="modal-body">
					<div id="cuerpo"><h4><spring:message code="sendCompra" />&nbsp;<spring:message code="selected" />?</h4></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
					<button type="button" class="btn btn-info" onclick="ejecutarLote(true)"><spring:message code="ok" /></button>
				</div>
			</div>
			<!-- /.modal-content -->
	    </div>
	  <!-- /.modal-dialog -->
	  </div>
	  <!-- Modal -->
  	  <div class="modal fade" id="modalEntrega" tabindex="-1" data-role="modalEntrega" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div id="titulo"><h3><spring:message code="confirm" /></h3></div>
				</div>
				<div class="modal-body">
					<div id="cuerpo"><h4><spring:message code="sendDeliver" />&nbsp;<spring:message code="selected" />?</h4></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
					<button type="button" class="btn btn-info" onclick="ejecutarLote(false)"><spring:message code="ok" /></button>
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
 

  <c:set var="confirmar"><spring:message code="confirm" /></c:set>
  <c:set var="finalize"><spring:message code="finalizeReview" /> <spring:message code="class ni.org.ics.solicitudes.domain.Solicitud" /></c:set>
  
  <c:set var="sendCompra"><spring:message code="sendCompra" /></c:set>
  <c:set var="sendDeliver"><spring:message code="sendDeliver" /></c:set>
  <c:set var="cancelItem"><spring:message code="cancel" /></c:set>
  <c:set var="viewBalance"><spring:message code="viewBalance" /></c:set>
  
  <c:set var="successmessage"><spring:message code="process.success" /></c:set>
  <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
  
  <c:set var="motivoCanceladaValidate"><spring:message code="motivoCanceladaValidate" /></c:set>
  
  <spring:url value="/sols/atender/verificar/items/compratodos/" var="comprarItemsUrl"></spring:url>
  <spring:url value="/sols/atender/verificar/items/entregatodos/" var="entregarItemsUrl"></spring:url>

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
          "columnDefs": [
              {
                  "targets": [ 9, 10 ],
                  "visible": false,
                  "searchable": false
              }
          ]
      });

	  table
      .on( 'select', function ( e, dt, type, indexes ) {
    	  var count = table.rows( { selected: true } ).count();
    	  count>0?$('#items_compra').prop('disabled', false):$('#items_compra').prop('disabled', true);
    	  count>0?$('#items_entrega').prop('disabled', false):$('#items_entrega').prop('disabled', true);
      } )
      .on( 'deselect', function ( e, dt, type, indexes ) {
    	  var count = table.rows( { selected: true } ).count();
    	  count>0?$('#items_compra').prop('disabled', false):$('#items_compra').prop('disabled', true);
    	  count>0?$('#items_entrega').prop('disabled', false):$('#items_entrega').prop('disabled', true);
      } );

	  $(".finalizar").click(function(){ 
			var nombreItem = $(this).data('nomitem');
			$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${finalize}"+' '+ nombreItem +'?</h3></br><h4>'+"${notUndo}"+'</h4>');
	    	$('#basic').modal('show');
	    });	

	  $('#lista_insumos').on('click', '.comprar', function(e){
		    $('#motivoCancelado').val("");
	    	$('#motivoCancelado').hide();
	        var nombreItem = $(this).data('nomitem');
	    	$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${sendCompra}"+ ' ' + nombreItem +'?</h3>');
	    	$('#basic').modal('show');
	    });

	  $('#lista_insumos').on('click', '.entregar', function(e){
		    $('#motivoCancelado').val("");
	    	$('#motivoCancelado').hide();
	        var nombreItem = $(this).data('nomitem');
	    	$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${sendDeliver}"+ ' ' + nombreItem +'?</h3>');
	    	$('#basic').modal('show');
	    });

	  $('#lista_insumos').on('click', '.cancelar', function(e){
		 	$('#motivoCancelado').val("");
	    	$('#motivoCancelado').show();	
	        var nombreItem = $(this).data('nomitem');
	    	$('#accionUrl').val($(this).data('whatever'));
	    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
	    	$('#cuerpo').html('<h3>'+"${cancelItem}"+ ' ' + nombreItem +'?</h3>');
	    	$('#basic').modal('show');
	    });	 
   


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


	  if ("${realizado}"){
			toastr.info("${successmessage}" , {
			    closeButton: true,
			    progressBar: true,
			  });
		} 

	  function ejecutarLote(comprar) {
	    	var dataSelected = table.rows( { selected: true } ).data();
	    	var itemsSeleccionados = "";
	    	var urlAccion="";
	    	comprar?urlAccion="${comprarItemsUrl}":urlAccion="${entregarItemsUrl}";
	        for (var i=0; i < dataSelected.length ;i++){
		        if(dataSelected[i][10]==="false"){
	        		itemsSeleccionados=="" ? itemsSeleccionados = dataSelected[i][9] : itemsSeleccionados = itemsSeleccionados + "," + dataSelected[i][9];
		        }
	        }		
	        $.blockUI({ message: "${waitmessage}" });
		    $.post( urlAccion
		            , {seleccionados:itemsSeleccionados}
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
	
  </script>
</body>
</html>