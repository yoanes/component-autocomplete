<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Set the default resource bundle for the current page. --%>    
<fmt:setBundle basename="project-environment" />    

<c:set var="wpmProxy">
    <fmt:message key="env.autocomplete.proxy.url" />
</c:set>
<c:set var="ymProxy">
    <fmt:message key="env.autocomplete.proxy.ym.url" />
</c:set>
<%-- No proxy required for location autocomplete.--%>
<c:set var="locationProxy" value="" />

<c:set var="emsJsUrl">
    <fmt:message key="env.ems.service.js" /><fmt:message key="env.ems.token" />
</c:set>

<autocomplete:bind device="${context.device}" toObserve="ypmKeywords" toPopulate="ypmSuggestions" 
    toURL="_AUTOCOMPLETE_YM_.defaultURL" preDataAdaptor="_AUTOCOMPLETE_YM_.defaultPreAdaptor"
    postDataAdaptor="_AUTOCOMPLETE_YM_.defaultPostAdaptor" minChar="_AUTOCOMPLETE_YM_.minChar"
    ulCSS="_AUTOCOMPLETE_YM_.defaultULCSS" proxy="${ymProxy}" />
    
<autocomplete:bind device="${context.device}" toObserve="wpmBusinessKeywords" toPopulate="wpmBusinessSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.business" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor" minChar="_AUTOCOMPLETE_WPM_.minChar"
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS" proxy="${wpmProxy}" />
    
<autocomplete:bind device="${context.device}" toObserve="wpmGovernmentKeywords" toPopulate="wpmGovernmentSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.government" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor" minChar="_AUTOCOMPLETE_WPM_.minChar"
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS" proxy="${wpmProxy}" />
    
<autocomplete:bind device="${context.device}" toObserve="wpmResidentialKeywords" toPopulate="wpmResidentialSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.residential" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor" minChar="_AUTOCOMPLETE_WPM_.minChar"
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS" proxy="${wpmProxy}" />
    
<autocomplete:bind device="${context.device}" toObserve="locKeywords" toPopulate="locSuggestions" 
    toURL="_AUTOCOMPLETE_LOCATION_.defaultHandler" preDataAdaptor="_AUTOCOMPLETE_LOCATION_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_LOCATION_.defaultPostAdaptor" minChar="_AUTOCOMPLETE_LOCATION_.minChar"
    ulCSS="_AUTOCOMPLETE_LOCATION_.defaultULCSS" proxy="${locationProxy}" emsJsUrl="${emsJsUrl}"/>

