<%@ tag body-content="empty" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="core" uri="/au/com/sensis/mobile/web/component/core/core.tld"%>
<%@ taglib prefix="ems" uri="/au/com/sensis/mobile/web/component/ems/ems.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/util/util.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/logging/logging.tld"%>

<%-- TODO --%>
<%--
<%@ attribute name="autocomplete" required="true"
    type="au.com.sensis.mobile.web.component.autocomplete.model.Map"  
    description="Map returned by the MapDelegate." %>
 --%>    

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.autocomplete" />
<logging:debug logger="${logger}" message="Entering setup.tag" />

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
<%--<core:script src="${compMcsBasePath}/autocomplete/scripts/autocomplete-component.mscr"></core:script>--%>

<c:if test="${not empty autocomplete}">
    <core:script name="bind-autocomplete" type="text/javascript">
        if(typeof(TODO) != 'undefined') {
            // Bind a field to autocomplete.         

        }
    </core:script>
</c:if>

<logging:debug logger="${logger}" message="Exiting setup.tag" />