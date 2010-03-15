<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp" />

<xf:model id="autocompleteFormModel">

    <xf:instance>
        <si:instance>

            <si:item name="ypmKeywords">
                <s:property value="location" />
            </si:item>
            <si:item name="wpmBusinessKeywords">
                <s:property value="location" />
            </si:item>
			<si:item name="locKeywords">
                <s:property value="location" />
            </si:item>
        </si:instance>
    </xf:instance>

</xf:model>

