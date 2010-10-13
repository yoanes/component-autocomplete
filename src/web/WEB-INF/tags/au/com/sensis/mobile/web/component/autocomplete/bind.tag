<%@ tag body-content="empty" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="base" uri="/au/com/sensis/mobile/web/component/core/base/base.tld"%>
<%@ taglib prefix="ems" uri="/au/com/sensis/mobile/web/component/core/ems/ems.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/core/util/util.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/core/logging/logging.tld"%>

<%@ attribute name="device" required="true"
    type="au.com.sensis.wireless.common.volantis.devicerepository.api.Device"  
    description="Device of the current user." %>
    
<%@ attribute name="toObserve" required="true"
    description="Id of the HTML input to provide autocomplete behaviour for." %>
<%@ attribute name="toPopulate" required="true"
    description="Id of the HTML element to populate with suggestions." %>
    
<%@ attribute name="toURL" required="true"
    description="URL to obtain autocomplete suggestions from." %>
<%@ attribute name="preDataAdaptor" required="true"
    description="Function to apply to the observed field input before appending it to the toURL." %>
<%@ attribute name="postDataAdaptor" required="true"
    description="Function to apply to the raw data to adapt it to the component's format." %>
    
<%@ attribute name="minChar" required="true"
    description="Minimum character needed before the autocomplete starts giving out suggestions." %>
<%@ attribute name="maxSuggestions" required="false"
    description="Maximum number of autocomplete suggestions to display." %>
    
<%@ attribute name="ulCSS" required="true"
    description="JSON object of styles to apply to the ul element for each suggestion." %>
<%@ attribute name="proxy" required="true"
    description="Http proxy to use to access the JSON endpoint, if any. Particularly useful to get around cross domain restrictions." %>
<%@ attribute name="emsJsUrl" required="false"
    description="Optional URL of the EMS JavaScript library. Only required if using location autocomplete." %>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.autocomplete" />
<logging:debug logger="${logger}" message="Entering bind.tag" />

<%--
  - Set attributes into request scope, then include a JSP so that we can route through the 
  - ContentRenderingFramework.
  --%>
<c:set var="autocompleteComponentDevice" scope="request" value="${device}" />
<c:set var="autocompleteComponentToObserve" scope="request" value="${toObserve}" />
<c:set var="autocompleteComponentToPopulate" scope="request" value="${toPopulate}" />
<c:set var="autocompleteComponentToURL" scope="request" value="${toURL}" />
<c:set var="autocompleteComponentPreDataAdaptor" scope="request" value="${preDataAdaptor}" />
<c:set var="autocompleteComponentPostDataAdaptor" scope="request" value="${postDataAdaptor}" />
<c:set var="autocompleteComponentMinChar" scope="request" value="${minChar}" />
<c:set var="autocompleteComponentMaxSuggestions" scope="request" value="${maxSuggestions}" />
<c:set var="autocompleteComponentUlCSS" scope="request" value="${ulCSS}" />
<c:set var="autocompleteComponentProxy" scope="request" value="${proxy}" />
<c:set var="autocompleteComponentEmsJsUrl" scope="request" value="${emsJsUrl}" />
<jsp:include page="/WEB-INF/view/jsp/comp/autocomplete/bind.crf" />

<logging:debug logger="${logger}" message="Exiting bind.tag" />
