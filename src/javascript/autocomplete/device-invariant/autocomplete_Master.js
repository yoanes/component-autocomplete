AUTOCOMPLETE = {};
AUTOCOMPLETE.instances = new Array();

var AutoCompletePrototype = new Class({
	Extends: Utilities,
	
	/* id of the field to be observerd */
	observe: new String(),
	/* id of the field to be populated with the result */
	populate: new String(),
	/* url where the query is submitted and returns back a result list */
	URL: new String(),
	/* minimum character before the query is sent to the URL */
	minChar: 2,
	/* interval between query */
	interval: 500,
	/* max number of results we are interested in */
	limit: 7,
	/* a method to transform the returned data to the conformed/agreed json format */
	postAdaptor: null,
	/* a method to transform the to-be-sent data to the conformed/agreed format */
	preAdaptor: null,
	
	/* some holder vars */
	intervalID: null,
	lastQuery: null,
	UL: null,

	/* backend url that will be this component's proxy */
	proxyUrl: new String(),
	
	/* default ul css that will get rendered out */
	defaultULCSS: {
		'listStyleType': 'none', 
		'border': '1px solid #d4d4d4',
		'paddingLeft': '0px',
		'backgroundColor': '#ffffff',
		'margin': '0px'
	},
	
	closeLink: null,
	clearDiv: null,
	
	nth: null,
	
	hideSuggestion: false,
	
	itemChose: false,
	
	initialize: function(toObserve, toPopulate, toURL, preDataAdaptor, postDataAdaptor, minChar, ulCSS, proxyUrl) {
		this.observe = toObserve;
		this.populate = toPopulate;
		this.URL = toURL;
		this.postAdaptor = postDataAdaptor;
		this.preAdaptor = preDataAdaptor;
		
		if(parseInt(minChar) >= 0) this.minChar = parseInt(minChar);
		
		this.proxyUrl = proxyUrl;

		/* create a unnumbered list and parse the default css for it */
		var ulList = new Element('ul');
		for(var defaultCSSAttr in this.defaultULCSS) {
			ulList.style[defaultCSSAttr] = this.defaultULCSS[defaultCSSAttr];
		}
		
		/* include the passed in css. NOTE: this will OVERWRITE the default one */
		if($defined(ulCSS)) {
			for(var cssAttr in ulCSS) 
				ulList.style[cssAttr] = ulCSS[cssAttr];
		}
		
		this.UL = ulList;

		if(this.populate.length > 0){
			$(this.populate).empty();
		}
		$(this.populate).appendChild(this.UL);
		$(this.populate).style.display = 'none';
		
		$(this.observe).addEventListener('focus', function(){this.startObserving();}.bind(this), false);
		$(this.observe).addEventListener('blur', function(){this.stopObserving(false);}.bind(this), false);
		
		/* force the autocorrect/autocomplete off */
		$(this.observe).setAttribute('autocorrect', 'off');
		$(this.observe).setAttribute('autocomplete', 'off');
		
		/* create the close link */
		this.closeLink = new Element('a');
		this.closeLink.href = 'javascript:void(0)';
		this.closeLink.style.textDecoration = 'none';
		this.closeLink.style.textTransform = 'lowercase';
		this.closeLink.style.color = '#888888';
		this.closeLink.addEventListener('click', function(e) { this.dropList(); this.hideSuggestion = true; return false; }.bind(this), false);
		
		/* create the static div to clear the float left */
		this.clearDiv = new Element('div');
		this.clearDiv.style.clear = 'both';
		this.clearDiv.style.height = '0px';
		
		/* add to the global component name space */
		this.nth = AUTOCOMPLETE.instances.push(this) - 1;
	},
	
	createItemList: function(liText, firstLastItem) {
		var includeCloseLink = false;
		
		var liList = new Element('li');	
		liList.style.padding = '3px 8px';
		
		var aList = new Element('a');
		aList.href = 'javascript:void(0)';
		aList.style.textDecoration = 'none';
		aList.style.display = 'block';
		aList.style.fontWeight = 'bold';
		aList.appendChild(document.createTextNode(liText));
		aList.addEventListener('click', function(e) { this.choose(liText); return false; }.bind(this), false);
		
		/* the first item should get the close link next to it */
		if(firstLastItem == 'first' || firstLastItem == 'only1') {
			includeCloseLink = true;
			
			/* add special style to the link */
			aList.style.width = '85%';
			aList.style.cssFloat = 'left';
			
			if(firstLastItem == 'only1'){
				/* make sure it doesn't render the bottom border if it's the only item in the list*/
				firstLastItem = 'last';
			}
		}
		
		/* parse the style of border bottom to all but the last */
		if(firstLastItem != 'last') {
			liList.style.borderBottom = '1px solid #d4d4d4';
		}
		
		liList.appendChild(aList);
		/* include the close link and the clear div if needed (*essentially only happens to the first li) */
		if(includeCloseLink) {
			/* don't forget to create the text node. If you instantiate it only on init(), it won't display on
			 * the 2nd or nth times of list display (1st display of list only)
			 */
			this.closeLink.appendChild(document.createTextNode('close'));
			liList.appendChild(this.closeLink);
			liList.appendChild(this.clearDiv)
		}
		this.UL.appendChild(liList);
	},
	
	choose: function(hrefText) {
		$(this.observe).value = hrefText;
		/* update the last query so the sendQuery doesn't trigger onfocus the next time */
		this.lastQuery = hrefText;
		this.itemChose = true;
		this.dropList();
	},
	
	/** no cross domain request is assumed here.
	 * the data url (especially for ym and wpm) is external (i.e. unmodifiable)
	 * thus the cross domain script-linking approach is out of the question
	 */
	sendQuery: function() {
		/* grab the value of the query */
		var qval = $(this.observe).value;
		
		/* discard results if the value is empty, and restart the hideSuggestion value */
		if(qval.length == 0) {
			this.dropList();
			this.hideSuggestion = false;
			this.lastQuery = "";
			return;
		}
		
		/* do the check 
		 * don't bother to check everything else if user opt to hide the auto suggest
		 * otherwise do the query length first becuase if it doesn't match we need to call dropList()
		 * the other check should just determine whether we're calling the ajax request or not and not touching the list
		 * */
		if(!this.hideSuggestion) {
			if(qval.length >= this.minChar){
				if(qval != this.lastQuery && this.URL.length > 0) {
					var finalQuery;
					
					/* try to format the data with preAdaptor before sending it */
					if(this.preAdaptor != null) {
						try { finalQuery = this.preAdaptor(qval); }
						catch(e) { finalQuery = qval; }
					}
					else finalQuery = qval;
					
					/* if we want to define our own function instead of parsing a url
					 * please defined the function and call the necessary methods to display
					 * the list upon completion or failure.  
					 * The component will handle the observation up to preAdaptor and then call the
					 * toURL function. Essentially, you're on your own
					 * from the point you send the data and onwards. You can still access the 
					 * methods from this class by calling AUTOCOMPLETE.instances[x] where x is passed
					 * as this.nth
					 * 
					 * NOTE: I DON'T LIKE THIS APPROACH BUT UNFORTUNATELY IT'S THE ONLY WAY AROUND FOR
					 * THE TIMEFRAME. IF YOU DON'T LIKE IT, GO IMPLEMENT IT YOURSELF
					 */
					if(this.URL instanceof Function) {
						this.URL(finalQuery, this.nth);
					}
					
					else {
						var ajax = new MobileRequest({
							method: 'get', 
							url: this.maintainSession(this.proxyUrl),
							onComplete: function(responseText) {
								if(this.itemChose) return;
								/* parse the list if any received back */
								if(responseText.length > 0) {
									var finalResult;
									/* oncomplete try to parse the data with postAdaptor if possible */
									if(this.postAdaptor != null) {
										try { finalResult = this.postAdaptor(responseText); }
										catch(e) { finalResult = responseText; }
									}
									else finalResult = responseText;
									/* parse the formatted data */
									this.populateResult(finalResult);
								}
								/* drop the list if no result is returned */
								else this.dropList();
							}.bind(this),
							/* log (if possible) on failure */
							onFailure: function(responseText) {
								try{ sensis.log(responseText); }
								catch(e) {}
							}
						}).send('url=' + encodeURIComponent(this.URL + finalQuery));
					}
					this.lastQuery = qval;
				}
			}
			/* drop the list if the minChar condition is not met */
			else this.dropList();
		}
	},
	
	/* parse data in json format
	 * 
	 * the json needs at least a "suggestions" attribute that contains an array of strings.
	 * if the data isn't in this format, you can alter it via postAdaptor
	 */
	populateResult: function(ajaxResponseText) {
		if($defined(ajaxResponseText)) {
			var objectList = JSON.decode(ajaxResponseText);
			var l = objectList.suggestions.length;
			if(l > 0) {
				/* clear the old list */
				this.dropList();
				/* loop through the data */
				for(var i = 0; i < l; i++) {
					/* stop after the limit is hit */
					if(i == this.limit) break;
					if(i == 0) {
						/* check if it is the only one item to display */
						if(i == l - 1) this.createItemList(objectList.suggestions[i], 'only1');
						/* otherwise render a normal item with close link */
						else this.createItemList(objectList.suggestions[i], 'first');
					}
					/* the last item shouldn't have any bottom border */
					else if(i == l - 1 || i == this.limit - 1) this.createItemList(objectList.suggestions[i], 'last');
					else this.createItemList(objectList.suggestions[i], '');
				}
				$(this.populate).style.display = 'block';
				/* scroll to top */
				this.forceFieldToTop();
			}
			/* drop the list if the array is empty.
			 * this happens to the base case of yellow data format where the 
			 * responseText length is never = 0 but the suggestions array is empty
			 */
			else this.dropList();
		}
	},
	
	startObserving: function() {
		this.intervalID = this.sendQuery.periodical(this.interval, this);
		this.itemChose = false;
	},
	
	stopObserving: function(doDropList) { 
		/* stop the observation */
		$clear(this.intervalID);
		/* check if the list contains anything */
		if(!$defined(doDropList)) doDropList = true;
		/* delete if the list is empty */
		if(doDropList) this.dropList();
	},
	
	/* Drop the result list */
	dropList: function() {
		if($(this.populate)) {
			this.UL.empty();
			$(this.populate).style.display = 'none';
		}
	}
});