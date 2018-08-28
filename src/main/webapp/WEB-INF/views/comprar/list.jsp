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
        <li class="breadcrumb-item active"><spring:message code="attend.shop" /></li>
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
              <i class="fa fa-credit-card"></i> <spring:message code="attend.shop" />
              <div class="card-actions">
              </div>
            </div>
            <div class="card-body">
              <table id="lista_insumos" class="table table-striped table-bordered datatable" width="100%">
                <thead>
                	<tr>
                		<th><spring:message code="numSolicitud" /></th>
                		<th><spring:message code="fecSolicitud" /></th>
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
			          	<th><spring:message code="actions" /></th>
                	</tr>
                </thead>
                <tbody>
                	<c:forEach items="${itemsComprar}" var="item">
						<tr>
							<spring:url value="/sols/atender/comprar/items/compra/{idItem}/" var="compraItemUrl">
                                <spring:param name="idItem" value="${item.idItem}" />
                            </spring:url>
                            <spring:url value="/sols/atender/comprar/items/entrega/{idItem}/" var="entregaItemUrl">
                                <spring:param name="idItem" value="${item.idItem}" />
                            </spring:url>
                            <spring:url value="/sols/atender/comprar/items/cancel/{idItem}/" var="cancelarItemUrl">
                                <spring:param name="idItem" value="${item.idItem}" />
                            </spring:url>
                            <td><c:out value="${item.solicitud.numSolicitud}" /></td>
                            <fmt:formatDate value="${item.solicitud.fecSolicitud}" var="datesolicitud" pattern="yyyy-MM-dd" />
                            <td><c:out value="${datesolicitud}" /></td>
							<td><c:out value="${item.insumo.codigoBrand}" /></td>
							<c:choose>
								<c:when test="${cookie.eSolicitudesLang.value == 'en'}">
									<td><c:out value="${item.insumo.nombreInsumoEn}" /></td>
								</c:when>
								<c:otherwise>
									<td><c:out value="${item.insumo.nombreInsumoEs}" /></td>
								</c:otherwise>
						  	</c:choose>
						  	<td><c:out value="${item.cantAutorizada}" /></td>
						  	<td><c:out value="${item.insumo.undMedida}" /></td>
						  	<td><c:out value="${item.presentacion}" /></td>
						  	<td><c:out value="${item.contenidoPresentacion}" /></td>
						  	<td><c:out value="${item.totalProducto}" /></td>
						  	<td><c:out value="${item.observaciones}" /></td>
						  	<td><c:out value="${item.estItem}" /></td>
						  	<td><c:out value="${item.idItem}" /></td>
							<td>	
								<a href="${fn:escapeXml(compraItemUrl)}" title="<spring:message code="shopThis" />" class="btn btn-outline-primary btn-sm"><i class="fa fa-shopping-cart"></i></a>										
								<a href="#" data-toggle="modal" title="<spring:message code="sendDeliver" />" data-nomitem="${item.insumo.codigoBrand}" data-whatever="${fn:escapeXml(entregaItemUrl)}" class="btn btn-outline-primary btn-sm entregar"><i class="fa fa-download"></i></a>
								<a href="#" data-toggle="modal" title="<spring:message code="cancel" />" data-nomitem="${item.insumo.codigoBrand}" data-whatever="${fn:escapeXml(cancelarItemUrl)}" class="btn btn-outline-primary btn-sm cancelar"><i class="fa fa-close"></i></a>
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
  
  <c:set var="confirmar"><spring:message code="confirm" /></c:set>
  <c:set var="sendDeliver"><spring:message code="sendDeliver" /></c:set>
  <c:set var="cancelItem"><spring:message code="cancel" /></c:set>
  <c:set var="successmessage"><spring:message code="process.success" /></c:set>
  <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
  
  <c:set var="motivoCanceladaValidate"><spring:message code="motivoCanceladaValidate" /></c:set>
  
  <!-- Custom scripts required by this view -->
  <script>
  	$(function(){
	  var tableSols = $('#lista_insumos').DataTable({
        "oLanguage": {
            "sUrl": "${dataTablesLang}"
        },
        "responsive": true,
        "columnDefs": [
            {
                "targets": [ 10,11 ],
                "visible": false,
                "searchable": false
            }
        ]
      });
	  $('.datatable').attr('style', 'border-collapse: collapse !important');      
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
  </script>
</body>
</html>