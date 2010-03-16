<%@ tag body-content="empty" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="core" uri="/au/com/sensis/mobile/web/component/core/core.tld"%>
<%@ taglib prefix="ems" uri="/au/com/sensis/mobile/web/component/ems/ems.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/util/util.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/logging/logging.tld"%>

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
<%@ attribute name="ulCSS" required="true"
    description="JSON object of styles to apply to the ul element for each suggestion." %>
<%-- TODO: Not used for now --%>    
<%--<%@ attribute name="maxSuggestions" required="false"
    description="Maximum number of autocomplete suggestions to display." %>--%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.autocomplete" />
<logging:debug logger="${logger}" message="Entering bind.tag" />

<core:compMcsBasePath var="compMcsBasePath" />

<%-- Setup components that we depend on. --%>
<core:setup />
<ems:setup />
<util:setup />
<logging:setup />

<%-- Themes for current component. --%>
<core:link rel="mcs:theme" href="${compMcsBasePath}/autocomplete/autocomplete.mthm" />
<core:link rel="mcs:theme"  href="${compMcsBasePath}/autocomplete/imageSizeCategory.mthm"/>

<%-- Scripts for current component. --%>
<core:script src="${compMcsBasePath}/autocomplete/scripts/autocomplete-component-jsconfig.mscr"></core:script>
<core:script src="${compMcsBasePath}/autocomplete/scripts/autocomplete-component.mscr"></core:script>

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.autocomplete.autocomplete-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>

<core:autoIncId var="autoCompleteVarName" prefix="${componentName}" />
<core:script name="${autoCompleteVarName}" type="text/javascript">
    if(typeof(AutoComplete) != 'undefined') {
        window.addEventListener('load', function() {
            <%--
              - We generate the name of the variable we assign to since there could be multiple
              - invocations of this tag on a page. Even though the variable isn't strictly
              - used, it will be useful for debugging. 
              --%>
            new AutoComplete(
                '<c:out value="${toObserve}"/>',
                '<c:out value="${toPopulate}"/>',
                <c:out value="${toURL}"/>,
                <c:out value="${preDataAdaptor}"/>,
                <c:out value="${postDataAdaptor}"/>,
                <c:out value="${ulCSS}"/>
            );
        }, false);
    }
</core:script>

<logging:debug logger="${logger}" message="Exiting bind.tag" />