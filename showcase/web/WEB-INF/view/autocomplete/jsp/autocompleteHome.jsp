<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<div id="autocompleteForm">
    <form>
        <div>
            <label for="ypmKeywords" style="display: block;">YPM</label>
            <input id="ypmKeywords" name="ypmKeywords" style="display: block;" />
        </div>
        <div id="ypmSuggestions"></div>
        
        <div>
            <label for="wpmBusinessKeywords" style="display: block;">WPM Business</label>
            <input id="wpmBusinessKeywords" name="wpmBusinessKeywords" style="display: block;" />
        </div>
        <div id="wpmBusinessSuggestions"></div>
        
        <div>
            <label for="wpmGovernmentKeywords" style="display: block;">WPM Government</label>
            <input id="wpmGovernmentKeywords" name="wpmGovernmentKeywords" style="display: block;" />
        </div>        
        <div id="wpmGovernmentSuggestions"></div>
        
        <div>
            <label for="wpmResidentialKeywords" style="display: block;">WPM Residential</label>
            <input id="wpmResidentialKeywords" name="wpmResidentialKeywords" style="display: block;" / >            
        </div>        
        <div id="wpmResidentialSuggestions"></div>
        
        <div>
            <label for="locKeywords" style="display: block;">Location</label>        
            <input id="locKeywords" name="locKeywords" />
        </div>
        <div id="locSuggestions"></div>
    </form>    
</div>
