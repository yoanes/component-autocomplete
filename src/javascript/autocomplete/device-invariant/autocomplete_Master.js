var AutoComplete = new Class({
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
	limit: 10,
	/* a method to transform the returned data to the conformed/agreed json format */
	postAdaptor: null,
	/* a method to transform the to-be-sent data to the conformed/agreed format */
	preAdaptor: null,
	
	/* some holder vars */
	intervalID: null,
	lastQuery: null,
	UL: null,
	
	/* special flag for the 2nd li */
	needClear: false,

	/* backend url that will be this component's proxy */
	_proxy_url_: _AutoCompleteProxy_,
	
	/* default ul css that will get rendered out */
	defaultULCSS: {
		'list-style-type': 'none', 
		'border': '1px solid #d4d4d4',
		'padding-left': '0px',
		'background-color': '#ffffff'
	},
	
	initialize: function(toObserve, toPopulate, toURL, preDataAdaptor, postDataAdaptor, ulCSS) {
		this.observe = toObserve;
		this.populate = toPopulate;
		this.URL = toURL;
		this.postAdaptor = postDataAdaptor;
		this.preAdaptor = preDataAdaptor;
		
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
	},
	
	createItemList: function(liText, firstLastItem) {
		var liList = new Element('li');	
		
		var aList = new Element('a');
		aList.href = '#';
		aList.style.textDecoration = 'none';
		aList.appendChild(document.createTextNode(liText));
		aList.addEventListener('click', function(e) { this.choose(liText); return false; }.bind(this), false);
		
		/* the first item should get the close link next to it */
		if(firstLastItem == 'first' || firstLastItem == 'only1') {
			var cList = new Element('a');
			cList.href = '#';
			cList.style.textDecoration = 'none';
			cList.appendChild(document.createTextNode('close'));
			cList.addEventListener('click', function(e) { this.dropList(); return false; }.bind(this), false);
			
			/* add special style */
			aList.style.width = '80%';
			aList.style.display = 'block';
			aList.style.cssFloat = 'left';
			
			if(firstLastItem == 'only1'){
				/* make sure it doesn't render the bottom border if it's the only item in the list*/
				firstLastItem == 'last';
			}
			/* otherwise flag the object to render a clear style on the next item */
			else this.needClear = true;
		}
		
		/* special style for the 2nd li */
		else if(this.needClear){
			liList.style.clear = 'both';
			this.needClear = false;
		}
		
		/* parse the style of border bottom to all but the last */
		if(firstLastItem != 'last') {
			liList.style.borderBottom = '1px solid #d4d4d4';
		}
		
		liList.appendChild(aList);
		/* include the close link if necessary */
		if(includeCloseLink) liList.appendChild(cList);
		this.UL.appendChild(liList);
	},
	
	choose: function(hrefText) {
		$(this.observe).value = hrefText;
		/* update the last query so the sendQuery doesn't trigger onfocus the next time */
		this.lastQuery = hrefText;
		this.dropList();
	},
	
	/** no cross domain request is assumed here.
	 * the data url (especially for ym and wpm) is external (i.e. unmodifiable)
	 * thus the cross domain script-linking approach is out of the question
	 */
	sendQuery: function() {
		/* grab the value of the query */
		var qval = $(this.observe).value;
		/* do the check */
		if(qval.length >= this.minChar && qval != this.lastQuery && this.URL.length > 0) {
			var finalQuery;
			
			/* try to format the data with preAdaptor before sending it */
			if(this.preAdaptor != null) {
				try { finalQuery = this.preAdaptor(qval); }
				catch(e) { finalQuery = qval; }
			}
			else finalQuery = qval;
				
			var ajax = new Request({
				method: 'get', 
				url: this.maintainSession(this._proxy_url_),
				onComplete: function(responseText) {
					/* oncomplete try to parse the data with postAdaptor if possible */
					if(this.postAdaptor != null) {
						try { var finalResult = this.postAdaptor(responseText); }
						catch(e) { var finalResult = responseText; }
					}
					else var finalResult = responseText;
					/* parse the formatted data */
					this.populateResult(finalResult);
				}.bind(this),
				/* log (if possible) on failure */
				onFailure: function(responseText) {
					try{ sensis.log(responseText); }
					catch(e) {}
				}
			}).send('url=' + encodeURIComponent(this.URL + finalQuery));
			
			this.lastQuery = qval;
		}
	},
	
	/* parse data in json format
	 * 
	 * the json needs at least a "suggestions" attribute that contains an array of strings.
	 * if the data isn't in this format, you can alter it via postAdaptor
	 */
	populateResult: function(ajaxResponseText) {
		if($defined(ajaxResponseText) && ajaxResponseText.length > 3) {
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
					else if(i == l - 1) this.createItemList(objectList.suggestions[i], 'last');
					else this.createItemList(objectList.data[i], '');
				}
				$(this.populate).style.display = 'block';
			}
		}
	},
	
	startObserving: function() {
		this.intervalID = this.sendQuery.periodical(this.interval, this);
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