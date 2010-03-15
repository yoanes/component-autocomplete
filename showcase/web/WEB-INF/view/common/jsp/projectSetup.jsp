<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<autocomplete:bind toObserve="ypmKeywords" toPopulate="ypmSuggestions" 
    toURL="_YM_.defaultURL" preDataAdaptor="_YM_.defaultPreAdaptor" postDataAdaptor="_YM_.defaultPostAdaptor" 
    ulCSS="_YM_.defaultULCSS"/>
    
<autocomplete:bind toObserve="wpmBusinessKeywords" toPopulate="wpmBusinessSuggestions" 
    toURL="_WPM_.defaultURL.business" preDataAdaptor="_WPM_.defaultPreAdaptor" postDataAdaptor="_WPM_.defaultPostAdaptor" 
    ulCSS="_WPM_.defaultULCSS"/>
    
    <autocomplete:bind toObserve="locKeywords" toPopulate="locSuggestions" 
    toURL="_LOCATION_.defaultHandler" preDataAdaptor="_LOCATION_.defaultPreAdaptor" postDataAdaptor="_LOCATION_.defaultPostAdaptor" 
    ulCSS="_LOCATION_.defaultULCSS"/>

