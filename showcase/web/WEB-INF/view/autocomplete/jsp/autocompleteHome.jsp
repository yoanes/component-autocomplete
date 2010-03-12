<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<div id="autocompleteForm">
    <xf:group model="autocompleteFormModel">
    
        <xf:input ref="ypmKeywords" model="autocompleteFormModel"
                id="ypmKeywords">
            <xf:label>YPM Search</xf:label>
        </xf:input>
    </xf:group>
    <div id="ypmSuggestions">
    
    </div>
</div>
