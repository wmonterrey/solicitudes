<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<jsp:include page="fragments/headTag.jsp" />
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
  <jsp:include page="fragments/bodyHeader.jsp" />
  <div class="app-body">
  	<!-- Navigation -->
  	<jsp:include page="fragments/sideBar.jsp" />
    <!-- Main content -->
    <main class="main">

      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item active">&nbsp;</li>
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
	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-docs bg-secondary p-3 font-2xl mr-3 float-left"> <c:out value="${totalSolicitudes.value}" /></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesCompletas.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesCompletas.value}" /> (<c:out value="${porcCompletas}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/SOLFIN/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a>
	                </div>
	              </div>
	            </div>
	            <!--/.col-->
	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-pencil bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesNuevas.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesNuevas.value}" /> (<c:out value="${porcNuevas}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/SOLNUE/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a>
	                </div>
	              </div>
	            </div>
	            <!--/.col-->
	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-check bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesSinAprobar.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesSinAprobar.value}" /> (<c:out value="${porcNoAprob}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/PENAPR/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a>
	                </div>
	              </div>
	            </div>
	            <!--/.col-->

	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-key bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesSinAutorizar.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesSinAutorizar.value}" /> (<c:out value="${porcNoAut}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/PENAUT/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a> 
	                </div>
	              </div>
	            </div>
	            <!--/.col-->

	                     
          </div>
          <!--/.row-->
          
          <div class="row">
	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-magnifier bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesSinRevisar.label}" /> </div>
	                  <div class="h5 text-right"><c:out value="${solicitudesSinRevisar.value}" /> (<c:out value="${porcARev}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/PENREV/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a>
	                </div>
	              </div>
	            </div>
	            <!--/.col-->
	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-credit-card bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesSinComprar.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesSinComprar.value}" /> (<c:out value="${porcACom}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/PENCOM/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a>
	                </div>
	              </div>
	            </div>
	            <!--/.col-->
	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-like bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesSinEntregar.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesSinEntregar.value}" /> (<c:out value="${porcAEnt}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/PENENT/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a>
	                </div>
	              </div>
	            </div>
	            <!--/.col-->

	            <div class="col-6 col-lg-3">
	              <div class="card">
	                <div class="card-body p-3 clearfix">
	                  <i class="icon-trash bg-secondary p-3 font-2xl mr-3 float-left"></i>
	                  <div class="text-uppercase text-muted font-weight-bold font-xs text-right mb-0 mt-2"><c:out value="${solicitudesEliminadas.label}" /></div>
	                  <div class="h5 text-right"><c:out value="${solicitudesEliminadas.value}" /> (<c:out value="${porcEliminadas}" />%)</div>
	                </div>
	                <div class="card-footer px-3 py-2">
	                  <a class="font-weight-bold font-xs btn-block text-muted" href="<spring:url value="/sols/ver/SOLELM/" htmlEscape="true "/>"><spring:message code="viewmore" /> <i class="fa fa-angle-right float-right font-lg"></i></a> 
	                </div>
	              </div>
	            </div>
	            <!--/.col-->

	                     
          </div>
          <!--/.row-->
          
          <div class="card">
            <div class="card-header">
              <spring:message code="solicitudesEstado" />
            </div>
            <div class="card-body">
              <div class="chart-wrapper" style="height:300px;margin-top:20px;">
                <div class="chart-wrapper" style="height:300px;margin-top:20px;">
                  <canvas id="estado-chart" height="300"></canvas>
                </div>
              </div>
            </div>
          </div>
          <!--/.card-->
          
          <div class="card-columns cols-2">
            <div class="card">
              <div class="card-header">
                <spring:message code="solicitudesCentro" />
                <div class="card-actions"></div>
              </div>
              <div class="card-body">
                <div class="chart-wrapper">
                  <canvas id="centro-chart"></canvas>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header">
                <spring:message code="solicitudesTipo" />
                <div class="card-actions"></div>
              </div>
              <div class="card-body">
                <div class="chart-wrapper">
                  <canvas id="tipo-chart"></canvas>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header">
                <spring:message code="solicitudesUsuario" />
                <div class="card-actions"></div>
              </div>
              <div class="card-body">
                <div class="chart-wrapper">
                  <canvas id="usuario-chart"></canvas>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header">
                <spring:message code="itemTipo" />
                <div class="card-actions"></div>
              </div>
              <div class="card-body">
                <div class="chart-wrapper">
                  <canvas id="insumo-tipo-chart"></canvas>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header">
                <spring:message code="itemCateg" />
                <div class="card-actions"></div>
              </div>
              <div class="card-body">
                <div class="chart-wrapper">
                  <canvas id="insumo-cat-chart"></canvas>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header">
                <spring:message code="solicitudesAtrasadas" />
                <div class="card-actions"></div>
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
		                    <th><spring:message code="usrSolicitud" /></th>
		                    <th><spring:message code="observaciones" /></th>
		                    <th><spring:message code="fecRequerida" /></th>
		                    <th><spring:message code="createdBy" /></th>
		                    <th><spring:message code="dateCreated" /></th>
							<th></th>
	                	</tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${atrasadas}" var="solicitud">
	                		<tr>
	                			<spring:url value="/sols/{idSolicitud}/"  var="solUrl">
	                                <spring:param name="idSolicitud" value="${solicitud.idSolicitud}" />
	                            </spring:url>
	                            <td><c:out value="${solicitud.numSolicitud}" /></td>
	                            <td><c:out value="${solicitud.fecSolicitud}" /></td>
	                            <td><c:out value="${solicitud.ctrSolicitud}" /></td>
	                            <td><c:out value="${solicitud.estSolicitud}" /></td>
	                            <td><c:out value="${solicitud.tipoSolicitud}" /></td>
	                            <td><c:out value="${solicitud.usrSolicitud}" /></td>
	                            <td><c:out value="${solicitud.observaciones}" /></td>
	                            <td><c:out value="${solicitud.fecRequerida}" /></td>
	                            <td><c:out value="${solicitud.recordUser}" /></td>
								<td><c:out value="${solicitud.recordDate}" /></td>
								<td><a href="${fn:escapeXml(solUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-search"></i></a></td>
	                		</tr>
	                	</c:forEach>
	                </tbody>
              	</table>
              </div>
            </div>
          </div>

        </div>

      </div>
      <!-- /.container-fluid -->
    </main>
    
  </div>
  <!-- Pie de página -->
  <jsp:include page="fragments/bodyFooter.jsp" />

  <!-- Bootstrap and necessary plugins -->
  <jsp:include page="fragments/corePlugins.jsp" />
  <jsp:include page="fragments/bodyUtils.jsp" />

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
  
  <spring:url value="/resources/vendors/js/jquery.dataTables.min.js" var="dataTablesSc" />
  <script src="${dataTablesSc}" type="text/javascript"></script>
  <spring:url value="/resources/vendors/js/dataTables.bootstrap4.min.js" var="dataTablesBsSc" />
  <script src="${dataTablesBsSc}" type="text/javascript"></script>
  
  <c:set var="welcome"><spring:message code="welcome" /><sec:authentication property="principal.username"/> </c:set>
  <c:set var="heading"><spring:message code="heading" /></c:set>
  <c:set var="solicitudesCentro"><spring:message code="solicitudesCentro" /></c:set>
  <c:set var="solicitudesEstado"><spring:message code="solicitudesEstado" /></c:set>
  <c:set var="solicitudesUsuario"><spring:message code="solicitudesUsuario" /></c:set>
  <c:set var="solicitudesTipo"><spring:message code="solicitudesTipo" /></c:set>
  <c:set var="itemCateg"><spring:message code="itemCateg" /></c:set>

<script>
$(function(){
  'use strict';

  toastr.info("${heading}", "${welcome}", {
    closeButton: true,
    progressBar: true,
  });

  $('.datatable').DataTable({
      "oLanguage": {
          "sUrl": "${dataTablesLang}"
      },
      "scrollX": true
  });
  $('.datatable').attr('style', 'border-collapse: collapse !important');

  var estados = [];
  var solEstados = [];


  <c:forEach var="estado" items="${porEstado}">
 	estados.push(["${estado.label}"]);
 	solEstados.push(["${estado.value}"]);
  </c:forEach>

  var dataSet1 = {
    labels: estados,
    datasets: [
      {
        type: 'bar',
        label: "${solicitudesEstado}",
        backgroundColor: '#ECECEC',
        borderColor: '#ECECEC',
        pointHoverBackgroundColor: '#fff',
        data: solEstados
      }
    ]
  };

  var ctx = $('#estado-chart');
  var mainChart = new Chart(ctx, {
    type: 'bar',
    data: dataSet1,
    options: {
        responsive: true,
        legend: {display: false},
  		"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}]}
      }
  });

  var centros = [];
  var solCentros = [];


  <c:forEach var="centro" items="${porCentro}">
  	centros.push(["${centro.label}"]);
  	solCentros.push(["${centro.value}"]);
  </c:forEach>

  var dataSet2 = {
   labels : centros,
   datasets : [
     {
   	label: "${solicitudesCentro}",  
       backgroundColor : 'rgba(48, 48, 48, 0.5)',
       borderColor : 'rgba(220,220,220,0.8)',
       highlightFill: 'rgba(220,220,220,0.75)',
       highlightStroke: 'rgba(220,220,220,1)',
       data : solCentros
     }
   ]
 }
 var ctx = document.getElementById('centro-chart');
 var chart = new Chart(ctx, {
   type: 'bar',
   data: dataSet2,
   options: {
     responsive: true,
     "scales":{"yAxes":[{"ticks":{"beginAtZero":true}}]}
   }
 });

 var tipos = [];
 var solTipos = [];

 <c:forEach var="tipo" items="${porTipo}">
 	tipos.push(["${tipo.label}"]);
 	solTipos.push(["${tipo.value}"]);
 </c:forEach>	
 
 var dataSet3 = {
   labels: tipos,
   datasets: [{
     data: solTipos,
     backgroundColor: [
       '#877264',
       '#bdbfab'
     ],
     hoverBackgroundColor: [
       '#877264',
       '#bdbfab'
     ]
   }]
 };
 var ctx = document.getElementById('tipo-chart');
 var chart = new Chart(ctx, {
   type: 'pie',
   data: dataSet3,
   options: {
     responsive: true
   }
 });


 var usuarios = [];
 var solUsuarios = [];


 <c:forEach var="usuario" items="${porUsuario}">
 	usuarios.push(["${usuario.label}"]);
 	solUsuarios.push(["${usuario.value}"]);
 </c:forEach>

 var dataSet4 = {
  labels : usuarios,
  datasets : [
    {
  	label: "${solicitudesUsuario}",  
      backgroundColor : 'rgba(48, 48, 48, 0.5)',
      borderColor : 'rgba(220,220,220,0.8)',
      highlightFill: 'rgba(220,220,220,0.75)',
      highlightStroke: 'rgba(220,220,220,1)',
      data : solUsuarios
    }
  ]
}
var ctx = document.getElementById('usuario-chart');
var chart = new Chart(ctx, {
  type: 'bar',
  data: dataSet4,
  options: {
    responsive: true,
    "scales":{"yAxes":[{"ticks":{"beginAtZero":true}}]}
  }
});

var itipos = [];
var itemTipos = [];

<c:forEach var="tipo" items="${iporTipo}">
	itipos.push(["${tipo.label}"]);
	itemTipos.push(["${tipo.value}"]);
</c:forEach>	

var dataSet5 = {
  labels: itipos,
  datasets: [{
    data: itemTipos,
    backgroundColor: [
      '#877264',
      '#bdbfab'
    ],
    hoverBackgroundColor: [
      '#877264',
      '#bdbfab'
    ]
  }]
};
var ctx = document.getElementById('insumo-tipo-chart');
var chart = new Chart(ctx, {
  type: 'pie',
  data: dataSet5,
  options: {
    responsive: true
  }
});

var icats = [];
var itemCats = [];

<c:forEach var="cat" items="${iporCat}">
	icats.push(["${cat.label}"]);
	itemCats.push(["${cat.value}"]);
</c:forEach>	

var dataSet6 = {
  labels : icats,
  datasets : [
    {
  	label: "${itemCateg}",  
      backgroundColor : 'rgba(48, 48, 48, 0.5)',
      borderColor : 'rgba(220,220,220,0.8)',
      highlightFill: 'rgba(220,220,220,0.75)',
      highlightStroke: 'rgba(220,220,220,1)',
      data : itemCats
    }
  ]
}
var ctx = document.getElementById('insumo-cat-chart');
var chart = new Chart(ctx, {
  type: 'bar',
  data: dataSet6,
  options: {
    responsive: true,
    "scales":{"yAxes":[{"ticks":{"beginAtZero":true}}]}
  }
});


  
});
</script>

</body>
</html>