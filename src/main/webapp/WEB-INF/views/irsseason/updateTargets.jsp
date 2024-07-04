<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../fragments/headTag.jsp" />
<!-- Styles required by this views -->
<spring:url value="/resources/vendors/css/select2.min.css" var="select2css" />
<link href="${select2css}" rel="stylesheet" type="text/css"/>

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

      <spring:url value="/irs/season/targets/saveUpdateTarget/" var="saveUrl"></spring:url>
  	  <spring:url value="/irs/season/targets/" var="targetUrl"></spring:url>

      <!-- Breadcrumb -->
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<spring:url value="/" htmlEscape="true "/>"><spring:message code="home" /></a></li>
        <li class="breadcrumb-item active"><a href="<spring:url value="/irs/dashboard/" htmlEscape="true "/>"><spring:message code="irs" /></a></li>
        <li class="breadcrumb-item"><a href="<spring:url value="/irs/season/targets/" htmlEscape="true "/>"><spring:message code="targets" /></a></li>
        <li class="breadcrumb-item active"><spring:message code="update" /></li>

      </ol>
    <!-- Container -->
	  <div class="container-fluid">
        <div class="animated fadeIn">
        	<div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-header">
                  <i class="fa fa-calendar-times-o"></i> <spring:message code="Update" />
                  <div class="card-actions">
                  </div>


                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-12">
                        <form action="#" autocomplete="off" id="update-form">
                          <div class="form-group row">
                            <div class="col-sm-6">
                                <label><spring:message code="season" /></label>
                                <select id="irsSeason" name="irsSeason" class="form-control select2-single">
                                    <c:forEach items="${temporadas}" var="temporada">
                                        <option value="${temporada.ident}">${temporada.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-6">
                              <label><spring:message code="locality" /></label>
                              <select id="localidad" name="localidad" class="form-control select2-single" >
                                  <!-- Options will be populated dynamically using JavaScript -->
                              </select>
                            </div>
                          </div>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary" id="guardar"><i class="fa fa-save"></i>&nbsp;<spring:message code="save" /></button>
                            <spring:url value="/irs/season/targets/" var="targetUrl"></spring:url>	
                            <a href="${fn:escapeXml(targetUrl)}" class="btn btn-danger"><i class="fa fa-undo"></i>&nbsp;<spring:message code="cancel" /></a>
                          </div>
                        </form>
                        <div style="display: none;">
                          <select id="meta0" name="meta0" class="form-control select2-single">
                            <c:forEach items="${metas}" var="meta">
                              <option value="${meta[0]}"></option>
                            </c:forEach>
                          </select>
                          <select id="meta1" name="meta1" class="form-control select2-single">
                            <c:forEach items="${metas}" var="meta">
                              <option value="${meta[1]}"></option>
                            </c:forEach>
                          </select>
                          <select id="meta2" name="meta2" class="form-control select2-single">
                            <c:forEach items="${metas}" var="meta">
                              <option value="${meta[2]}"></option>
                            </c:forEach>
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>



                </div>
              </div>
            </div>
            </div>
        </div>
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
	<c:when test="${cookie.evcaLang.value == null}">
		<c:set var="lenguaje" value="es"/>
	</c:when>
	<c:otherwise>
		<c:set var="lenguaje" value="${cookie.evcaLang.value}"/>
	</c:otherwise>
  </c:choose>

 <!-- Plugins and scripts required by this views -->
 <spring:url value="/resources/vendors/js/jquery.validate.min.js" var="JQueryValidate" />
 <script src="${JQueryValidate}" type="text/javascript"></script>
 <spring:url value="/resources/vendors/js/i18n/validation/messages_{language}.js" var="jQValidationLoc">
     <spring:param name="language" value="${lenguaje}" />
 </spring:url>

 <c:set var="successmessage"><spring:message code="process.success" /></c:set>
 <c:set var="errormessage"><spring:message code="process.errors" /></c:set>
 <c:set var="waitmessage"><spring:message code="process.wait" /></c:set>
 <c:set var="noResults"><spring:message code="noResults" /></c:set>

 <spring:url value="/irs/season/targets/updateTargets" var="updateTargetUrl"/>

 <!-- Custom scripts required by this view -->
 <spring:url value="/resources/js/views/ActualizarMetas.js" var="ProcessEntity" />
 <script src="${ProcessEntity}"></script>


 <script>
  jQuery(document).ready(function() {
    var parametros = {saveUrl: "${saveUrl}", targetUrl: "${targetUrl}",
        successmessage: "${successmessage}", 
        errormessage: "${errormessage}",
        waitmessage: "${waitmessage}" ,
        dataTablesLang: "${dataTablesLang}",
        noResults: "${noResults}"
      };
      ProcessEntity.init(parametros);
  });
</script>
</body>

</html>
