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
        <li class="breadcrumb-item active"><spring:message code="criaderos" /></li>
        
      </ol>
	  <!-- Container -->
	  <div class="container-fluid">
      <div class="animated fadeIn">
          <div class="card">
            <div class="card-header">
              <i class="fa fa-bug"></i> <spring:message code="criaderos" />
              <div class="card-actions">
              </div>
            </div>
            <div class="card-body">
              <spring:url value="/admin/criaderos/newEntity/"	var="newEntity"/>
              <spring:url value="/admin/criaderos/map/"	var="viewMap"/>
              <button id="lista_criaderos_new" onclick="location.href='${fn:escapeXml(newEntity)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-plus"></i>&nbsp; <spring:message code="add" /></button>
              <div class="row float-right mr-4" >
              	<button id="criaderos_map" onclick="location.href='${fn:escapeXml(viewMap)}'" type="button" class="btn btn-outline-primary"><i class="icon-globe"></i>&nbsp; <spring:message code="map" /></button>
              </div>
              
              <br><br><br><br>	
              <table id="lista_criaderos" class="table table-striped table-bordered datatable" width="100%">
                <thead>
                	<tr>
	                    <th class="hidden-xs"><spring:message code="locality" /></th>
	                    <th class="hidden-xs"><spring:message code="criadtipo" /></th>
	                    <th class="hidden-xs"><spring:message code="criadinfo" /></th>
	                    <th><spring:message code="enabled" /></th>
	                    <th><spring:message code="createdBy" /></th>
	                    <th><spring:message code="dateCreated" /></th>
	                    <th></th>
                	</tr>
                </thead>
                <tbody>
                	<c:forEach items="${criaderos}" var="criadero">
                		<tr>
                			<spring:url value="/admin/criaderos/{id}/"
                                        var="idUrl">
                                <spring:param name="id" value="${criadero.ident}" />
                            </spring:url>
                            <spring:url value="/admin/criaderos/editEntity/{id}/"
                                        var="editUrl">
                                <spring:param name="id" value="${criadero.ident}" />
                            </spring:url>
                            <td class="hidden-xs"><a href="${fn:escapeXml(idUrl)}"><c:out value="${criadero.local.name}" /></a></td>
                            <td class="hidden-xs"><c:out value="${criadero.tipo}" /></td>
                            <td class="hidden-xs"><c:out value="${criadero.info}" /></td>
                            <c:choose>
                                <c:when test="${criadero.pasive eq '0'.charAt(0)}">
                                    <td><span class="badge badge-success"><spring:message code="CAT_SINO_SI" /></span></td>
                                </c:when>
                                <c:otherwise>
                                    <td><span class="badge badge-danger"><spring:message code="CAT_SINO_NO" /></span></td>
                                </c:otherwise>
                            </c:choose>
                            <td><c:out value="${criadero.recordUser}" /></td>
                            <td><c:out value="${criadero.recordDate}" /></td>
                            <td><a href="${fn:escapeXml(idUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-search"></i></a><a href="${fn:escapeXml(editUrl)}" class="btn btn-outline-primary btn-sm"><i class="fa fa-pencil"></i></a></td>
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
  <jsp:include page="../fragments/bodyFooter.jsp" />

  <!-- Bootstrap and necessary plugins -->
  <jsp:include page="../fragments/corePlugins.jsp" />
  <jsp:include page="../fragments/bodyUtils.jsp" />
  
  <!-- GenesisUI main scripts -->
  <spring:url value="/resources/js/app.js" var="App" />
  <script src="${App}" type="text/javascript"></script>

  <!-- Lenguaje -->
  <c:choose>
	<c:when test="${cookie.evcaLang.value == null}">
		<c:set var="lenguaje" value="es"/>
	</c:when>
	<c:otherwise>
		<c:set var="lenguaje" value="${cookie.evcaLang.value}"/>
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