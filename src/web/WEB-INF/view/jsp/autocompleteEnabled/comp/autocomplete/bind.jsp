<%@ page trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="base" uri="/au/com/sensis/mobile/web/component/core/base/base.tld"%>
<%@ taglib prefix="ems" uri="/au/com/sensis/mobile/web/component/core/ems/ems.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/core/util/util.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/core/logging/logging.tld"%>
<%@ taglib prefix="crf" uri="/au/com/sensis/mobile/crf/crf.tld"%>

<%--
  - Grab attributes from request scope.
  --%>
<c:set var="device" value="${autocompleteComponentDevice}" />
<c:set var="toObserve" value="${autocompleteComponentToObserve}" />
<c:set var="toPopulate" value="${autocompleteComponentToPopulate}" />
<c:set var="toURL" value="${autocompleteComponentToURL}" />
<c:set var="preDataAdaptor" value="${autocompleteComponentPreDataAdaptor}" />
<c:set var="postDataAdaptor" value="${autocompleteComponentPostDataAdaptor}" />
<c:set var="minChar" value="${autocompleteComponentMinChar}" />
<c:set var="maxSuggestions" value="${autocompleteComponentMaxSuggestions}" />
<c:set var="ulCSS" value="${autocompleteComponentUlCSS}" />
<c:set var="proxy" value="${autocompleteComponentProxy}" />
<c:set var="emsJsUrl" value="${autocompleteComponentEmsJsUrl}" />


<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.autocomplete.autocomplete-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>
    
<%-- Setup components that we depend on. --%>
<base:setup device="${device}" />

<c:if test="${fn:length(emsJsUrl) > 0}">
    <ems:setup emsJsUrl="${emsJsUrl}" device="${device}" />
</c:if>

<util:setup device="${device}" />
<logging:setup device="${device}" />

<%-- Themes for current component: Not applicable. --%>

<%-- Scripts for current component. --%>
<crf:script src="comp/autocomplete/package" type="text/javascript" device="${device}"></crf:script>

<base:autoIncId var="autoCompleteScriptName" prefix="${componentName}" />
<crf:script name="${autoCompleteScriptName}" type="text/javascript" device="${device}">
	(function(autoCompleteInitParam) {
		if(!$defined(window._AutoCompleteInitParam_)) 
			window._AutoCompleteInitParam_ = new Array();
		window._AutoCompleteInitParam_.push(autoCompleteInitParam);	
	})({
		toObserve: '<c:out value="${toObserve}"/>',
		toPopulate: '<c:out value="${toPopulate}"/>',
		toUrl: <c:out value="${toURL}"/>,
		preDataAdaptor: <c:out value="${preDataAdaptor}"/>,
		postDataAdaptor: <c:out value="${postDataAdaptor}"/>,
		minChar: <c:out value="${minChar}"/>,
		maxSuggestion: '<c:out value="${maxSuggestions}"/>',
		ulCSS: <c:out value="${ulCSS}"/>,
		proxy: '<c:out value="${proxy}"/>'
	});
</crf:script>
