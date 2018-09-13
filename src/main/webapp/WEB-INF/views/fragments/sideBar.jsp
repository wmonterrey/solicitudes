<%@ page contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<div class="sidebar">
    <nav class="sidebar-nav">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="<spring:url value="/" htmlEscape="true "/>"><i class="icon-graph"></i><spring:message code="dashboard" /></a>
            </li>
            
            <sec:authorize url="/sols/">
            <li class="nav-item nav-dropdown solicitudes">
            	<a class="nav-link nav-dropdown-toggle" href="#"><i class="icon-docs"></i><spring:message code="sols" /></a>
            	<ul class="nav-dropdown-items">
            		<li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/sols/" htmlEscape="true "/>"><i class="icon-plus"></i><spring:message code="sols.enter" /></a>
	                </li>
	                <sec:authorize url="/sols/aprobar/">
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/sols/aprobar/" htmlEscape="true "/>"><i class="icon-check"></i><spring:message code="sols.aprob" /></a>
	                </li>
	                </sec:authorize>
	                <sec:authorize url="/sols/autorizar/">
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/sols/autorizar/" htmlEscape="true "/>"><i class="icon-key"></i><spring:message code="sols.aut" /></a>
	                </li>
	                </sec:authorize>
            	</ul>
            </li>
	        </sec:authorize>
	        
	        <sec:authorize url="/sols/atender/">
            <li class="nav-item nav-dropdown atendersols">
            	<a class="nav-link nav-dropdown-toggle" href="#"><i class="icon-basket"></i><spring:message code="attend" /></a>
            	<ul class="nav-dropdown-items">
            		<li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/sols/atender/verificar/" htmlEscape="true "/>"><i class="icon-magnifier-add"></i><spring:message code="attend.verif" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/sols/atender/comprar/" htmlEscape="true "/>"><i class="icon-credit-card"></i><spring:message code="attend.shop" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/sols/atender/entregar/" htmlEscape="true "/>"><i class="fa fa-truck"></i><spring:message code="attend.deliver" /></a>
	                </li>
            	</ul>
            </li>
	        </sec:authorize>
	        
	        <sec:authorize url="/procesos/">
            <li class="nav-item nav-dropdown envios">
            	<a class="nav-link nav-dropdown-toggle" href="#"><i class="icon-drawer"></i><spring:message code="process" /></a>
            	<ul class="nav-dropdown-items">
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/procesos/compras/" htmlEscape="true "/>"><i class="icon-basket-loaded"></i><spring:message code="process.shop" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/procesos/entregas/" htmlEscape="true "/>"><i class="icon-cloud-download"></i><spring:message code="process.deliver" /></a>
	                </li>
            	</ul>
            </li>
	        </sec:authorize>
            
            <sec:authorize url="/super/">
            <li class="nav-item nav-dropdown configuracion">
	            <a class="nav-link nav-dropdown-toggle" href="#"><i class="icon-wrench"></i><spring:message code="super" /></a>
	            <ul class="nav-dropdown-items">
	            	<li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/super/insumos/" htmlEscape="true "/>"><i class="icon-basket-loaded"></i><spring:message code="itemcat" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/super/traduccion/" htmlEscape="true "/>"><i class="icon-globe"></i><spring:message code="translation" /></a>
	                </li>
	            </ul>
	        </li>
	        </sec:authorize>
            
            <sec:authorize url="/admin/">
            <li class="nav-item nav-dropdown administracion">
	            <a class="nav-link nav-dropdown-toggle" href="#"><i class="icon-settings"></i><spring:message code="admin" /></a>
	            <ul class="nav-dropdown-items">
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/admin/users/" htmlEscape="true "/>"><i class="icon-people"></i><spring:message code="users" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/admin/centers/" htmlEscape="true "/>"><i class="fa fa-building"></i><spring:message code="centers" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/admin/estudios/" htmlEscape="true "/>"><i class="fa fa-archive"></i><spring:message code="studies" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/admin/cuentas/" htmlEscape="true "/>"><i class="fa fa-usd"></i><spring:message code="accounts" /></a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="<spring:url value="/admin/catalogos/" htmlEscape="true "/>"><i class="icon-book-open"></i><spring:message code="seccatalogs" /></a>
	                </li>
	            </ul>
	        </li>
	        </sec:authorize>
            <li class="nav-item nav-dropdown lenguaje">
	            <a class="nav-link nav-dropdown-toggle" href="#"><i class="fa fa-language"></i><spring:message code="language" /></a>
	            <ul class="nav-dropdown-items">
	                <li class="nav-item">
	                    <a class="nav-link" href="?lang=en"><i class="fa fa-flag"></i>English</a>
	                    <a class="nav-link" href="?lang=es"><i class="icon-flag"></i>Español</a>
	                </li>
	            </ul>
	        </li>
	        
	        <li class="nav-item">
                <a class="nav-link" href="<spring:url value="/logout" htmlEscape="true" />"><i class="icon-logout"></i><spring:message code="logout" /></a>
            </li>
            
        </ul>
    </nav>
    <button class="sidebar-minimizer brand-minimizer" type="button"></button>
</div>