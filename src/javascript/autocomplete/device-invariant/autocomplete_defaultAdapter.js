/***************************************** 
 * YELLOW DEFAULT PARAMETERS
 */
_YM_ = {};

_YM_.defaultURL = "http://www.yellowpages.com.au/suggest/business?";

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

_WPM_.defaultURL = {};
_WPM_.defaultURL.business = "http://www.whitepages.com.au/wp/autosuggest/autoSuggest.x?type=businessName&";
_WPM_.defaultURL.government = "http://www.whitepages.com.au/wp/autosuggest/autoSuggest.x?type=governmentName&";
_WPM_.defaultURL.residential = "http://www.whitepages.com.au/wp/autosuggest/autoSuggest.x?type=residentialName&";

_WPM_.defaultPreAdaptor = function(query) {
	return "q=" + query + "&limit=7&timestamp=" + new Date().getTime();
}

_WPM_.defaultPostAdaptor = function(resultText) {
	/* replace any occurance of \n (new line character) with , (comma) */
	var pass1 = new RegExp('^(.*)$', 'gm');
	var pass2 = new RegExp(',$', '');
	
	var afterReplacement = resultText.replace(pass1, "\"$1\",");
	afterReplacement = afterReplacement.replace(pass2, "");

	return "{'suggestions': [" + afterReplacement + "]}";
}

_WPM_.defaultULCSS = {
	'-webkit-border-radius':'5px',
	'-webkit-box-shadow': '1px 1px 3px #bbbbbb'
}

/***************************************** 
* DEFAULT PARAMETERS FOR LOCATION
*/
_LOCATION_ = {};

_LOCATION_.defaultHandler = function(query, nth_instance) {
	var geocoder = new EMS.Services.Geocoder();
	
	/* apparently EMS doesn't retrieve anything below 3 characters */
	if(query.length < 3) return;

	var options = {};
	var data2Send = {};
	data2Send.address = {};
	data2Send.address.suburb = query;
	
	geocoder.findLocalityByPrefix(data2Send, function(addresses){
		var addressesLength = addresses.results.length;
		if(addressesLength > 0) {
			var finalResult = "{'suggestions': [";
			for(var i = 0; i < addressesLength; i++) {
				var address = addresses.results[i];
				finalResult = finalResult.concat("\"",address.suburb, address.region, ", ", address.state, "\"");
				if(i != addressesLength -1) finalResult = finalResult.concat(",");
			}
			finalResult = finalResult.concat("]}");
			AUTOCOMPLETE.instances[nth_instance].populateResult(finalResult);
		}
	}, options); 
}

_LOCATION_.defaulPreAdaptor = _LOCATION_.defaultPostAdaptor = _LOCATION_.defaultULCSS = null;