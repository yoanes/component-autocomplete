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
<%@ attribute name="ulCSS" required="true"
    description="JSON object of styles to apply to the ul element for each suggestion." %>
<%@ attribute name="proxy" required="true"
    description="Http proxy to use to access the JSON endpoint, if any. Particularly useful to get around cross domain restrictions." %>
<%@ attribute name="includeEms" required="true"
    description="True if you need the EMS libraries included. eg. if you are using EMS for auto completing locations." %>
<%-- TODO: Not used for now --%>    
<%--<%@ attribute name="maxSuggestions" required="false"
    description="Maximum number of autocomplete suggestions to display." %>--%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.autocomplete" />
<logging:debug logger="${logger}" message="Entering bind.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.autocomplete.autocomplete-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>
<base:deviceConfig var="deviceConfig" device="${device}" 
    registryBeanName="${componentName}.comp.deviceConfigRegistry"/>

<c:if test="${deviceConfig.enableAutocomplete}">
    
    <%-- Setup components that we depend on. --%>
    <base:setup />
    
    <c:if test="${includeEms}">
        <ems:setup />
    </c:if>
    
    <util:setup />
    <logging:setup />
    
    <base:compMcsBasePath var="compMcsBasePath" />
    
    <%-- Themes for current component: Not applicable. --%>
    
    <%-- Scripts for current component. --%>
    <base:script src="${compMcsBasePath}/autocomplete/scripts/autocomplete-component-jsconfig.mscr"></base:script>
    <base:script src="${compMcsBasePath}/autocomplete/scripts/autocomplete-component.mscr"></base:script>
    
    <base:autoIncId var="autoCompleteScriptName" prefix="${componentName}" />
    <base:script name="${autoCompleteScriptName}" type="text/javascript">
        if(typeof(AutoComplete) != 'undefined') {
            window.addEventListener('load', function() {
                new AutoComplete(
                    '<c:out value="${toObserve}"/>',
                    '<c:out value="${toPopulate}"/>',
                    <c:out value="${toURL}"/>,
                    <c:out value="${preDataAdaptor}"/>,
                    <c:out value="${postDataAdaptor}"/>,
                    <c:out value="${minChar}"/>,
                    <c:out value="${ulCSS}"/>,
                    <c:out value="${proxy}"/>
                );
            }, false);
        }
    </base:script>

</c:if>

<logging:debug logger="${logger}" message="Exiting bind.tag" />