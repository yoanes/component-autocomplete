<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<autocomplete:bind toObserve="ypmKeywords" toPopulate="ypmSuggestions" 
    toURL="_AUTOCOMPLETE_YM_.defaultURL" preDataAdaptor="_AUTOCOMPLETE_YM_.defaultPreAdaptor" postDataAdaptor="_AUTOCOMPLETE_YM_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_YM_.defaultULCSS"/>
    
<autocomplete:bind toObserve="wpmBusinessKeywords" toPopulate="wpmBusinessSuggestions" 
    toURL="_AUTOCOMPLETE_WPM_.defaultURL.business" preDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPreAdaptor" postDataAdaptor="_AUTOCOMPLETE_WPM_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_WPM_.defaultULCSS"/>
    
    <autocomplete:bind toObserve="locKeywords" toPopulate="locSuggestions" 
    toURL="_AUTOCOMPLETE_LOCATION_.defaultHandler" preDataAdaptor="_AUTOCOMPLETE_LOCATION_.defaultPreAdaptor" postDataAdaptor="_AUTOCOMPLETE_LOCATION_.defaultPostAdaptor" 
    ulCSS="_AUTOCOMPLETE_LOCATION_.defaultULCSS"/>

