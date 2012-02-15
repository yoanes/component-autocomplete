/*****************************************
 * YELLOW DEFAULT PARAMETERS
 */
_AUTOCOMPLETE_YM_ = {};

_AUTOCOMPLETE_YM_.defaultURL = "http://www.yellowpages.com.au/suggest/business?";

_AUTOCOMPLETE_YM_.defaultPreAdaptor = function(query) {
	return "query=" + encodeURIComponent(query);
}

/** the default behaviour of the autocomplete is based on YM's json data structure
 * hence YM doesn't need the default post adaptor
 */
_AUTOCOMPLETE_YM_.defaultPostAdaptor = _AUTOCOMPLETE_YM_.minChar = null;

_AUTOCOMPLETE_YM_.defaultULCSS = null;

/*****************************************
 * WHITE DEFAULT PARAMETERS
 */
_AUTOCOMPLETE_WPM_ = {};

_AUTOCOMPLETE_WPM_.defaultURL = {};
_AUTOCOMPLETE_WPM_.defaultURL.business = "http://www.whitepages.com.au/autosuggest/autoSuggest.x?type=businessName&";
_AUTOCOMPLETE_WPM_.defaultURL.government = "http://www.whitepages.com.au/autosuggest/autoSuggest.x?type=governmentName&";
_AUTOCOMPLETE_WPM_.defaultURL.residential = "http://www.whitepages.com.au/autosuggest/autoSuggest.x?type=residentialName&";

_AUTOCOMPLETE_WPM_.defaultPreAdaptor = function(query) {
	return "q=" + encodeURIComponent(query) + "&limit=7&timestamp=" + new Date().getTime();
}

_AUTOCOMPLETE_WPM_.defaultPostAdaptor = function(resultText) {
	/* replace any occurance of \n (new line character) with , (comma) */
	var pass1 = new RegExp('^(.*)$', 'gm');
	var pass2 = new RegExp(',$', '');

	var afterReplacement = resultText.replace(pass1, "\"$1\",");
	afterReplacement = afterReplacement.replace(pass2, "");

	return "{'suggestions': [" + afterReplacement + "]}";
}

_AUTOCOMPLETE_WPM_.defaultULCSS = {
	'-webkit-border-radius':'5px',
	'-webkit-box-shadow': '1px 1px 3px #bbbbbb'
}

_AUTOCOMPLETE_WPM_.minChar = null;

/*****************************************
* DEFAULT PARAMETERS FOR LOCATION
*/
_AUTOCOMPLETE_LOCATION_ = {};

_AUTOCOMPLETE_LOCATION_.minChar = 3;

_AUTOCOMPLETE_LOCATION_.defaultHandler = function(query, nth_instance) {
    EMS.Services.communicationMode = 'CrossDomain';
	var geocoder = new EMS.Services.Geocoder();

	/* apparently EMS doesn't retrieve anything below 3 characters */
	if(query.length < _AUTOCOMPLETE_LOCATION_.minChar) return;

	/* Ignore any exceptions since we can't do anything about them. */
	var options = {onException: function(e) {}} ;

	var data2Send = {};
	data2Send.address = {};
	data2Send.address.suburb = query;

	geocoder.findLocalityByPrefix(data2Send, function(addresses){
		var addressesLength = addresses.results.length;
		if(addressesLength > 0) {
			var finalResult = "{'suggestions': [";
			for(var i = 0; i < addressesLength; i++) {
				var address = addresses.results[i];
				finalResult = finalResult.concat("\"",address.suburb.toLowerCase(), address.region.toLowerCase(), " ", address.state, "\"");
				if(i != addressesLength -1) finalResult = finalResult.concat(",");
			}
			finalResult = finalResult.concat("]}");
			AUTOCOMPLETE.instances[nth_instance].populateResult(finalResult);
		}
		else AUTOCOMPLETE.instances[nth_instance].dropList();
	}, options);
}

_AUTOCOMPLETE_LOCATION_.defaulPreAdaptor = _AUTOCOMPLETE_LOCATION_.defaultPostAdaptor = null;

_AUTOCOMPLETE_LOCATION_.defaultULCSS = {
	'-webkit-border-radius':'5px',
	'-webkit-box-shadow': '1px 1px 3px #bbbbbb',
	'textTransform': 'capitalize'
}

/*****************************************
* LOCATION EMS V2 DEFAULT PARAMETERS
*/
_AUTOCOMPLETE_LOCATION2_ = {};

_AUTOCOMPLETE_LOCATION2_.defaultURL = "http://wiemsrs01d.in.sensis.com.au:24121/v2/service/search/suggest";

_AUTOCOMPLETE_LOCATION2_.defaultPreAdaptor = function(query) {
	return "?query=" + encodeURIComponent(query);
}

_AUTOCOMPLETE_LOCATION2_.defaultULCSS = {
	'-webkit-border-radius':'5px',
	'-webkit-box-shadow': '1px 1px 3px #bbbbbb'
}

_AUTOCOMPLETE_LOCATION2_.defaultPostAdaptor = _AUTOCOMPLETE_LOCATION2_.minChar = null;