/***************************************** 
 * YELLOW DEFAULT PARAMETERS
 */
_YM_ = {};

_YM_.defaultURL = "http://dyela.yellowpages.sensis.com.au/suggest/business?";

_YM_.defaultPreAdaptor = function(query) {
	return "query=" + query;
}

/** the default behaviour of the autocomplete is based on YM's json data structure
 * hence YM doesn't need the default post adaptor
 */
_YM_.defaultPostAdaptor = null;

_YM_.defaultULCSS = null;

/***************************************** 
 * WHITE DEFAULT PARAMETERS
 */
_WPM_ = {};

_WPM_.defaultURL.business = "http://www.whitepages.com.au/wp/autosuggest/autoSuggest.x?type=businessName";
_WPM_.defaultURL.government = "http://www.whitepages.com.au/wp/autosuggest/autoSuggest.x?type=governmentName";
_WPM_.defaultURL.residential = "http://www.whitepages.com.au/wp/autosuggest/autoSuggest.x?type=residentialName";

_WPM_.defaultPreAdaptor = function(query) {
	return "q=" + query + "&limit=7&timestamp=" + new Date().getTime();
}

_WPM_.defaultPostAdaptor = function(resultText) {
	/* replace any occurance of \n (new line character) with , (comma) */
	var afterReplacement = resultText.replace(new RegExp('\n', 'g'), ",");
	return "{'suggestions': [" + afterReplacement + "]}";
}

_WPM_.defaultULCSS = {
	'-webkit-border-radius':'5px',
	'-webkit-box-shadow': '1px 1px 3px #bbbbbb'
}