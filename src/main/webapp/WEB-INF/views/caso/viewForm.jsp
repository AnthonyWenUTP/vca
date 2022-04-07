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

<spring:url value="/resources/vendors/css/select2.min.css" var="select2css" />
<link href="${select2css}" rel="stylesheet" type="text/css"/>

<spring:url value="/resources/vendors/css/leaflet.css" var="leafletCSS" />
<link href="${leafletCSS}" rel="stylesheet" type="text/css"/>

<spring:url value="/resources/vendors/css/datepicker.css" var="datepickercss" />
<link href="${datepickercss}" rel="stylesheet" type="text/css"/>
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
        <li class="breadcrumb-item"><a href="<spring:url value="/admin/casos/" htmlEscape="true "/>"><spring:message code="cases" /></a></li>
        <li class="breadcrumb-item active"><c:out value="${caso.codigo}" /></li>
        
      </ol>
	  <!-- Container -->
      <div class="container-fluid">
      	<div class="animated fadeIn">
			<spring:url value="/admin/casos/invno/{id}/" var="invnoUrl">
				<spring:param name="id" value="${caso.ident}" />
			</spring:url>
			<c:set var="labelinvno"><spring:message code="invno" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labelinvsi"><spring:message code="invsi" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labelinvDate"><spring:message code="invDate" /></c:set>
			
			<c:set var="labeltxsi"><spring:message code="txsi" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labeltxno"><spring:message code="txno" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labeltxDate"><spring:message code="txDate" /></c:set>
			<spring:url value="/admin/casos/txno/{id}/" var="txnoUrl">
				<spring:param name="id" value="${caso.ident}" />
			</spring:url>
			
			<c:set var="labeltxCompsi"><spring:message code="txCompsi" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labeltxCompno"><spring:message code="txCompno" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labeltxCompDate"><spring:message code="txCompDate" /></c:set>
			<spring:url value="/admin/casos/txCompno/{id}/" var="txCompnoUrl">
				<spring:param name="id" value="${caso.ident}" />
			</spring:url>
			
			<c:set var="labeltxSupsi"><spring:message code="txSupsi" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labeltxSupno"><spring:message code="txSupno" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labeltxSupdias"><spring:message code="diastxSup" /></c:set>
			
			
			
			<c:set var="labelsxsi"><spring:message code="sxsi" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labelsxno"><spring:message code="sxno" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labelsxDate"><spring:message code="sxDate" /></c:set>
			<spring:url value="/admin/casos/sxno/{id}/" var="sxnoUrl">
				<spring:param name="id" value="${caso.ident}" />
			</spring:url>
			
			
			<c:set var="labelsxCompsi"><spring:message code="sxCompsi" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labelsxCompno"><spring:message code="sxCompno" /> <c:out value="${caso.codigo}" /></c:set>
			<c:set var="labelsxCompDate"><spring:message code="sxCompDate" /></c:set>
			<spring:url value="/admin/casos/sxCompno/{id}/" var="sxCompnoUrl">
				<spring:param name="id" value="${caso.ident}" />
			</spring:url>
			
			
          	<div class="row">
	            <div class="col-md-6">
	              <div class="card">
		               	<div class="card-header">
		                  <i class="icon-compass"></i>&nbsp;<strong><c:out value="${caso.codigo}" /></strong>
		                  <ul class="nav nav-tabs float-right  mr-4">
						  <li class="nav-item dropdown">
						    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><i class="icon-settings">&nbsp;<spring:message code="actions" /></i></a>
						    <div class="dropdown-menu">
						    	
						    	<c:if test="${caso.inv eq '1'}">
						    		<a class="dropdown-item desact" data-nomitem="${labelinvno}" data-toggle="modal" data-whatever="${fn:escapeXml(invnoUrl)}"><i class="fa fa-times"></i> <spring:message code="invno" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.inv eq '0'}">
						    		<a class="dropdown-item accionsi" data-elemento="inv" data-nomitem="${labelinvsi}" data-pregitem="${labelinvDate}" data-toggle="modal"><i class="fa fa-check"></i> <spring:message code="invsi" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.tx eq '1' and caso.txComp eq '0' and caso.sx eq '0' and caso.sxComp eq '0'}">
						    		<a class="dropdown-item desact" data-nomitem="${labeltxno}" data-toggle="modal" data-whatever="${fn:escapeXml(txnoUrl)}"><i class="fa fa-times"></i> <spring:message code="txno" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.tx eq '0'}">
						    		<a class="dropdown-item accionsi" data-elemento="tx" data-nomitem="${labeltxsi}" data-pregitem="${labeltxDate}" data-toggle="modal"><i class="fa fa-check"></i> <spring:message code="txsi" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.tx eq '1'}">
						    		<a class="dropdown-item acciondiassi" data-elemento="txSup" data-nomitem="${labeltxSupsi}" data-pregitem="${labeltxSupdias}" data-toggle="modal"><i class="fa fa-check"></i> <spring:message code="txSupsi" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.txComp eq '1' and caso.sx eq '0' and caso.sxComp eq '0'}">
						    		<a class="dropdown-item desact" data-nomitem="${labeltxCompno}" data-toggle="modal" data-whatever="${fn:escapeXml(txCompnoUrl)}"><i class="fa fa-times"></i> <spring:message code="txCompno" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.txComp eq '0' and caso.tx eq '1'}">
						    		<a class="dropdown-item accionsi" data-elemento="txComp" data-nomitem="${labeltxCompsi}" data-pregitem="${labeltxCompDate}" data-toggle="modal"><i class="fa fa-check"></i> <spring:message code="txCompsi" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.sx eq '1'}">
						    		<a class="dropdown-item desact" data-nomitem="${labelsxno}" data-toggle="modal" data-whatever="${fn:escapeXml(sxnoUrl)}"><i class="fa fa-times"></i> <spring:message code="sxno" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.sx eq '0' and caso.txComp eq '1'}">
						    		<a class="dropdown-item accionressi" data-elemento="sx" data-nomitem="${labelsxsi}" data-pregitem="${labelsxDate}" data-toggle="modal"><i class="fa fa-check"></i> <spring:message code="sxsi" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.sxComp eq '1'}">
						    		<a class="dropdown-item desact" data-nomitem="${labelsxCompno}" data-toggle="modal" data-whatever="${fn:escapeXml(sxCompnoUrl)}"><i class="fa fa-times"></i> <spring:message code="sxCompno" /></a>
						    	</c:if>
						    	
						    	<c:if test="${caso.sxComp eq '0' and caso.txComp eq '1'}">
						    		<a class="dropdown-item accionressi" data-elemento="sxComp" data-nomitem="${labelsxCompsi}" data-pregitem="${labelsxCompDate}" data-toggle="modal"><i class="fa fa-check"></i> <spring:message code="sxCompsi" /></a>
						    	</c:if>
						    	
						    </div>
						  </li>
						</ul>
		                </div>
	                	<div class="card-body">
	                		<div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="ident" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.ident}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="codigo" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.codigo}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="caseState" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.estadocaso}" /></strong></p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.fisDate}" var="fecSintomas" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="fisDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecSintomas}" /></strong></p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.mxDate}" var="fecMuestra" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="mxDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecMuestra}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="inv" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static">
		                        	<c:choose>
										<c:when test="${caso.inv eq '1'}">
											<strong><spring:message code="CAT_SINO_SI" /></strong>
										</c:when>
										<c:otherwise>
											<strong><spring:message code="CAT_SINO_NO" /></strong>
										</c:otherwise>
									</c:choose>
								</p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.invDate}" var="fecInv" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="invDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecInv}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="tx" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static">
		                        	<c:choose>
										<c:when test="${caso.tx eq '1'}">
											<strong><spring:message code="CAT_SINO_SI" /></strong>
										</c:when>
										<c:otherwise>
											<strong><spring:message code="CAT_SINO_NO" /></strong>
										</c:otherwise>
									</c:choose>
								</p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.txDate}" var="fecIniTx" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="txDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecIniTx}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="txSup" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.txSup}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="txComp" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static">
		                        	<c:choose>
										<c:when test="${caso.txComp eq '1'}">
											<strong><spring:message code="CAT_SINO_SI" /></strong>
										</c:when>
										<c:otherwise>
											<strong><spring:message code="CAT_SINO_NO" /></strong>
										</c:otherwise>
									</c:choose>
								</p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.txCompDate}" var="fecCompTx" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="txCompDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecCompTx}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="sx" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static">
		                        	<c:choose>
										<c:when test="${caso.sx eq '1'}">
											<strong><spring:message code="CAT_SINO_SI" /></strong>
										</c:when>
										<c:otherwise>
											<strong><spring:message code="CAT_SINO_NO" /></strong>
										</c:otherwise>
									</c:choose>
								</p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.sxDate}" var="fecIniSx" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="sxDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecIniSx}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="sxResult" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.sxResult}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="sxComp" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static">
		                        	<c:choose>
										<c:when test="${caso.sxComp eq '1'}">
											<strong><spring:message code="CAT_SINO_SI" /></strong>
										</c:when>
										<c:otherwise>
											<strong><spring:message code="CAT_SINO_NO" /></strong>
										</c:otherwise>
									</c:choose>
								</p>
		                      </div>
		                    </div>
		                    <fmt:formatDate value="${caso.sxCompDate}" var="fecCompSx" pattern="dd/MM/yyyy" />
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="sxCompDate" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${fecCompSx}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="locality" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.local.name}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="district" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.local.district.name}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="area" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.local.district.area.name}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="location" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.latitude}" /> , <c:out value="${caso.longitude}" />, <c:out value="${caso.zoom}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="infopdx" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.info}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="enabled" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong>
		                        	<c:choose>
										<c:when test="${caso.pasive=='0'.charAt(0)}">
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
		                        <p class="form-control-static"><strong><c:out value="${caso.recordUser}" /></strong></p>
		                      </div>
		                    </div>
		                    <div class="form-group row">
		                      <label class="col-md-3 col-form-label"><spring:message code="dateCreated" />:</label>
		                      <div class="col-md-9">
		                        <p class="form-control-static"><strong><c:out value="${caso.recordDate}" /></strong></p>
		                      </div>
		                    </div>
	                    	<spring:url value="/admin/casos/editEntity/{ident}/" var="editUrl">
                              	<spring:param name="ident" value="${caso.ident}" />
                          	</spring:url>
            					<spring:url value="/admin/casos/disableEntity/{ident}/" var="disableUrl">
                              	<spring:param name="ident" value="${caso.ident}" />
                          	</spring:url>
                          	<spring:url value="/admin/casos/enableEntity/{ident}/" var="enableUrl">
                              	<spring:param name="ident" value="${caso.ident}" />
                          	</spring:url>
                          	<spring:url value="/admin/casos/enterLocation/{ident}/" var="locationUrl">
                              	<spring:param name="ident" value="${caso.ident}" />
                          	</spring:url>
						</div>
						<div class="card-header">
          				<div class="row float-right mr-4" >
          					<button id="edit_entity" onclick="location.href='${fn:escapeXml(editUrl)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-pencil"></i>&nbsp; <spring:message code="edit" /></button>
          					<c:choose>
								<c:when test="${caso.pasive=='0'.charAt(0)}">
									<button id="disable_entity" onclick="location.href='${fn:escapeXml(disableUrl)}'" type="button" class="btn btn-outline-danger"><i class="fa fa-close"></i>&nbsp; <spring:message code="disable" /></button>
								</c:when>
								<c:otherwise>
									<button id="enable_entity" onclick="location.href='${fn:escapeXml(enableUrl)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-check"></i>&nbsp; <spring:message code="enable" /></button>
								</c:otherwise>
						 	</c:choose>
						 	<button id="location_button" onclick="location.href='${fn:escapeXml(locationUrl)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-location-arrow"></i>&nbsp; <spring:message code="location" /></button>
          					<button id="back_button" onclick="location.href='<spring:url value="/admin/casos/" htmlEscape="true "/>'" type="button" class="btn btn-outline-primary"><i class="fa fa-undo"></i>&nbsp; <spring:message code="back" /></button>
          				</div>
            			</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card">
						<div class="card-body">
							<div id="mapid" style="width: 100%; height: 680px;"></div>
						</div>
					</div>
				</div>
	            <!--/.col-->
         	</div>
         	
         	
         	
            <div class="row">
	            <div class="col-md-12">
	              <div class="card">
	                <div class="card-header">
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
  	  <div class="modal fade" id="datesForm" data-role=""datesForm"" data-backdrop="static" data-aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div id="titulo"><h2 class="modal-title"><spring:message code="confirm" /></h2></div>
				</div>
				<div class="modal-body">
					<input type="hidden" id="accionUrl"/>
					<div id="encabezado"></div>
					<div id="elemento"></div>
					<div id="cuerpo">
						<form action="#" role="form" autocomplete="off" id="add-form">
						<div class="form-group">
							<input type="text" id="ident" name="ident" readonly hidden value="${caso.ident}" class="form-control" placeholder="<spring:message code="ident" />">
	                      	<input type="text" id="dataElement" name="dataElement" readonly hidden class="form-control">
	                    </div>
	                    <div class="form-group fecha">
	                      <div class="input-group">
	                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                        <input type="text" id="dateValue" name="dateValue"  class="form-control date-picker" data-date-format="dd/mm/yyyy" data-date-start-date="-180d" data-date-end-date="+0d">
	                      </div>
	                    </div> 
	                    <div class="form-group dias">
		                	<div class="input-group">
		                		<label>Día 1</label>
		                		<input type="checkbox" id="dia1" name="dia1" class="form-control" value="1">
		                	</div>
		                	<div class="input-group">
		                		<label>Día 2</label>
		                		<input type="checkbox" id="dia2" name="dia2" class="form-control" value="2">
		                	</div>
		                </div>
		                <div class="form-group resultado">
		                	<i class="fa fa-map-o"></i>
		                    <label><spring:message code="sxResult" /></label>
		                    <select id="resultado" name="resultado" class="form-control select2-single">
		                      <c:forEach items="${resultados}" var="resultado">
		                      	<option selected value="${resultado.catKey}"><spring:message code="${resultado.messageKey}" /></option>
		                      </c:forEach>
		                    </select>
		                </div>
	                    <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="cancel" /></button>
						<button type="submit" id="buttonAgregarData" class="btn btn-info"><spring:message code="ok" /></button>
	                    </form>
					</div>
				</div>
				<div class="modal-footer">
				</div>
			</div>
			<!-- /.modal-content -->
	    </div>
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
	<c:when test="${cookie.eSivinLang.value == null}">
		<c:set var="lenguaje" value="es"/>
	</c:when>
	<c:otherwise>
		<c:set var="lenguaje" value="${cookie.eSivinLang.value}"/>
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
  
  <spring:url value="/resources/vendors/js/leaflet.js" var="leafletJS" />
  <script src="${leafletJS}" type="text/javascript"></script>
    <spring:url value="/resources/vendors/js/select2.min.js" var="Select2" />
  <script src="${Select2}" type="text/javascript"></script>
  
  <spring:url value="/resources/vendors/js/bootstrap-datepicker.js" var="datepicker" />
  <script src="${datepicker}" type="text/javascript"></script>
  
    <!-- Custom scripts required by this view -->
  <spring:url value="/resources/js/views/Entidad.js" var="processEntity" />
  <script src="${processEntity}"></script>
  
  <c:set var="entityEnabledLabel"><spring:message code="enabled" /></c:set>
  <c:set var="entityDisabledLabel"><spring:message code="disabled" /></c:set>
  <c:set var="exito"><spring:message code="process.success" /></c:set>
  <c:set var="confirmar"><spring:message code="confirm" /></c:set>
  <spring:url value="/admin/casos/dateValue/saveEntity/" var="saveUrl"></spring:url>
  <spring:url value="/admin/casos/" var="listUrl"/>	
  
  <spring:url value="/admin/casos/{id}/"
              var="listUrl">
      <spring:param name="id" value="${caso.ident}" />
  </spring:url>
      
  <c:set var="successmessage"><spring:message code="process.success" /></c:set>
  <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
  <c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
  
  <script>
  	jQuery(document).ready(function() {
		var parametros = {saveUrl: "${saveUrl}", successmessage: "${successmessage}",
				errormessage: "${errormessage}",waitmessage: "${waitmessage}",
				listUrl: "${listUrl}", latitudMinima: "${latitudMinima}", latitudMaxima: "${latitudMaxima}"  
					, longitudMinima: "${longitudMinima}", longitudMaxima: "${longitudMaxima}" 
		};
		ProcessEntity.init(parametros);
	});
  
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
    

   
    
    if ("${entidadHabilitada}"){
		toastr.info("${entityEnabledLabel}", "${nombreEntidad}", {
		    closeButton: true,
		    progressBar: true,
		  } );
	}
	if ("${entidadDeshabilitada}"){
		toastr.error("${entityDisabledLabel}", "${nombreEntidad}" , {
		    closeButton: true,
		    progressBar: true,
		  });
	}
	
	
	if ("${completo}"){
		toastr.info("${exito}", {
		    closeButton: true,
		    progressBar: true,
		  } );
	}
	
	$(".desact").click(function(){ 
    	var nombreItem = $(this).data('nomitem');
    	$('#accionUrl').val($(this).data('whatever'));
    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
    	$('#cuerpo').html('<h3>'+ nombreItem +'?</h3>');
    	$('#basic').modal('show');
    });
	
	
	$(".accionsi").click(function(){ 
    	var nombreItem = $(this).data('nomitem');
    	var nombreElemento = $(this).data('pregitem');
    	var elemento = $(this).data('elemento');
    	$('#accionUrl').val($(this).data('whatever'));
    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
    	$('#encabezado').html('<h3>'+ nombreItem +'?</h3>');
    	$('#elemento').html('<h5>'+ nombreElemento +'</h5>');
    	$('#dataElement').val(elemento);
    	$('.dias').hide();
    	$('.resultado').hide();
    	$('#datesForm').modal('show');
    });
	
	$(".acciondiassi").click(function(){ 
    	var nombreItem = $(this).data('nomitem');
    	var nombreElemento = $(this).data('pregitem');
    	var elemento = $(this).data('elemento');
    	$('#accionUrl').val($(this).data('whatever'));
    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
    	$('#encabezado').html('<h3>'+ nombreItem +'?</h3>');
    	$('#elemento').html('<h5>'+ nombreElemento +'</h5>');
    	$('#dataElement').val(elemento);
    	$('.fecha').hide();
    	$('.resultado').hide();
    	$('#datesForm').modal('show');
    });
	
	$(".accionressi").click(function(){ 
    	var nombreItem = $(this).data('nomitem');
    	var nombreElemento = $(this).data('pregitem');
    	var elemento = $(this).data('elemento');
    	$('#accionUrl').val($(this).data('whatever'));
    	$('#titulo').html('<h2 class="modal-title">'+"${confirmar}"+'</h2>');
    	$('#encabezado').html('<h3>'+ nombreItem +'?</h3>');
    	$('#elemento').html('<h5>'+ nombreElemento +'</h5>');
    	$('#dataElement').val(elemento);
    	$('.dias').hide();
    	$('#datesForm').modal('show');
    });
	
	
	function ejecutarAccion() {
		window.location.href = $('#accionUrl').val();		
	}
	
	
	var mymap = L.map('mapid').setView([${latitude}, ${longitude}], ${zoom});

	L.tileLayer('http://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
		maxZoom: 18,
		attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
			'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
		id: 'mapbox.streets'
	}).addTo(mymap);
	
	var miLat = "${caso.latitude}";
	var miLong = "${caso.longitude}";
	
	if(!(miLat == "" || miLong == "")){
		var marker = L.marker([${caso.latitude}, ${caso.longitude}]).addTo(mymap);
		marker.bindTooltip("${caso.codigo}");
	}
	
	var popup = L.popup();

  </script>
</body>
</html>