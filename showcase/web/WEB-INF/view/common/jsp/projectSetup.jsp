<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<autocomplete:bind device="${context.device}" toObserve="ypmKeywords" toPopulate="ypmSuggestions" 
    toURL="_AUTOCOMPLETE_YM_.defaultURL" preDataAdaptor="_AUTOCOMPLETE_YM_.defaultPreAdaptor"
    postDataAdaptor="_AUTOCOMPLETE_YM_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_YM_.defaultULCSS" proxy="_AUTOCOMPLETE_YM_.proxy" includeEms="false"/>
    
<autocomplete:bind device="${context.device}" toObserve="wpmBusinessKeywords" toPopulate="wpmBusinessSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.business" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS" proxy="_AUTOCOMPLETE_WPM_.proxy" includeEms="false"/>
    
<autocomplete:bind device="${context.device}" toObserve="wpmGovernmentKeywords" toPopulate="wpmGovernmentSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.government" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS" proxy="_AUTOCOMPLETE_WPM_.proxy" includeEms="false"/>
    
<autocomplete:bind device="${context.device}" toObserve="wpmResidentialKeywords" toPopulate="wpmResidentialSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.residential" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor"
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS" proxy="_AUTOCOMPLETE_WPM_.proxy" includeEms="false"/>
    
<autocomplete:bind device="${context.device}" toObserve="locKeywords" toPopulate="locSuggestions" 
    toURL="_AUTOCOMPLETE_LOCATION_.defaultHandler" preDataAdaptor="_AUTOCOMPLETE_LOCATION_.defaultPreAdaptor" 
    postDataAdaptor="_AUTOCOMPLETE_LOCATION_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_LOCATION_.defaultULCSS" proxy="_AUTOCOMPLETE_LOCATION_.proxy" includeEms="true"/>

