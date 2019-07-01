<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../../fragments/headTag.jsp" />
<!-- Styles required by this views -->

<spring:url value="/resources/vendors/css/leaflet.css" var="leafletCSS" />
<link href="${leafletCSS}" rel="stylesheet" type="text/css"/>

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
        <li class="breadcrumb-item active"><spring:message code="localities" /></li>
        
      </ol>
	  <!-- Container -->
	  <div class="container-fluid">
      <div class="animated fadeIn">
          <div class="card">
            <div class="card-header">
              <i class="icon-compass"></i> <spring:message code="localities" />
              <div class="card-actions">
              </div>
            </div>
            <div class="card-body">
              <spring:url value="/admin/localities/newEntity/"	var="newEntity"/>
              <spring:url value="/admin/localities/"	var="viewList"/>	
              <button id="lista_localities_new" onclick="location.href='${fn:escapeXml(newEntity)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-plus"></i>&nbsp; <spring:message code="add" /></button>
              <div class="row float-right mr-4" >
              	<button id="localities_list" onclick="location.href='${fn:escapeXml(viewList)}'" type="button" class="btn btn-outline-primary"><i class="fa fa-list-ul"></i>&nbsp; <spring:message code="list" /></button>
              </div>
              <br><br>
              <div id="mapid" style="width: 100%; height: 500px;"></div>
              
            </div>
          </div>
        </div>
        </div>
      <!-- /.container-fluid -->
    </main>
    
  </div>
  <!-- Pie de página -->
  <jsp:include page="../../fragments/bodyFooter.jsp" />

  <!-- Bootstrap and necessary plugins -->
  <jsp:include page="../../fragments/corePlugins.jsp" />
  <jsp:include page="../../fragments/bodyUtils.jsp" />
  
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
  
  <spring:url value="/resources/vendors/js/leaflet.js" var="leafletJS" />
  <spring:url value="/resources/img//icons-maps/blue.png" var="iconBlue" />
  <script src="${leafletJS}" type="text/javascript"></script>
  
  <!-- Custom scripts required by this view -->
  
  <script>
  
	  	var mymap = L.map('mapid').setView([${latitude}, ${longitude}], ${zoom});
		
		var theMarker = {};
		var locMarkers = new L.FeatureGroup();
		


		L.tileLayer('http://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
			maxZoom: 18,
			attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
				'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
				'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
			id: 'mapbox.streets'
		}).addTo(mymap);
		
		
		var PointIcon = L.Icon.extend({
		    options: {
		        iconSize:     [16, 16]
		    }
		});
		
		var blueIcon = new PointIcon({iconUrl: '${iconBlue}'});
		
		<c:forEach var="localidad" items="${localidades}">
			var miLat = "${localidad.latitude}";
			var miLong = "${localidad.longitude}";
			
			if(!(miLat == "" || miLong == "")){
				theMarker = L.marker([${localidad.latitude}, ${localidad.longitude}],{title: "${viewList}"+"/"+"${localidad.ident}"+"/"}).addTo(mymap).setIcon(blueIcon).on('click', onClick);
				theMarker.addTo(locMarkers);
				theMarker.bindTooltip("${localidad.name}");
			}
		</c:forEach>
		mymap.fitBounds(locMarkers.getBounds());
		var popup = L.popup();
		
		function onClick(e) {
			window.location.href = this.options.title;
		}

  </script>
</body>
</html>