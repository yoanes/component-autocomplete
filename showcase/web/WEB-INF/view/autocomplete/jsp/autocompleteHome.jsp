<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<div id="autocompleteForm">
    <div>
        <xf:group model="autocompleteFormModel">
            <xf:input ref="ypmKeywords" model="autocompleteFormModel"
                    id="ypmKeywords" style="display: block;">
                <xf:label style="display: block;">YPM</xf:label>
            </xf:input>
        </xf:group>
    </div>
    <div id="ypmSuggestions"></div>
    
    <div>
        <xf:group model="autocompleteFormModel">
            <xf:input ref="wpmBusinessKeywords" model="autocompleteFormModel"
                        id="wpmBusinessKeywords" style="display: block;">
                <xf:label style="display: block;">WPM Business</xf:label>
            </xf:input>
        </xf:group>
    </div>
    <div id="wpmBusinessSuggestions"></div>
    
    <div>
        <xf:group model="autocompleteFormModel">
            <xf:input ref="wpmGovernmentKeywords" model="autocompleteFormModel"
                        id="wpmGovernmentKeywords" style="display: block;">
                <xf:label style="display: block;">WPM Government</xf:label>
            </xf:input>
        </xf:group>
    </div>        
    <div id="wpmGovernmentSuggestions"></div>
    
    <div>
        <xf:group model="autocompleteFormModel">
            <xf:input ref="wpmResidentialKeywords" model="autocompleteFormModel"
                        id="wpmResidentialKeywords" style="display: block;">
                <xf:label style="display: block;">WPM Residential</xf:label>
            </xf:input>
        </xf:group>
    </div>        
    <div id="wpmResidentialSuggestions"></div>
    
    <div>
        <xf:group model="autocompleteFormModel">
        
            <xf:input ref="locKeywords" model="autocompleteFormModel"
                        id="locKeywords">
                <xf:label style="display: block;">Location</xf:label>
            </xf:input>
        </xf:group>
    </div>
    <div id="locSuggestions"></div>
    
</div>
