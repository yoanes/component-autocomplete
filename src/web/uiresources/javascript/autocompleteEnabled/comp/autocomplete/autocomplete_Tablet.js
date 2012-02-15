var AutoCompleteTabletPrototype = new Class({
	Extends: AutoCompletePrototype,
	
	/* override the parent's method */
	createItemList: function(liText, firstLastItem) {
		var includeCloseLink = false;
		
		var liList = new Element('li');	
		
		var aList = new Element('a');
		aList.href = 'javascript:void(0)';
		aList.className = 'ac_suggest';
		
		if(liText instanceof Object) {
			try {
				aList.id = liText.id;
				aList.appendChild(document.createTextNode(liText.text));
				aList.addEventListener('click', function(e) { 
					this.choose(liText.text); 
					this._lastSelectedId = liText.id;
					return false;
				}.bind(this), false);
			} catch(e){}
		}
		
		else { 
			aList.appendChild(document.createTextNode(liText)); 
			aList.addEventListener('click', function(e) { this.choose(liText); return false; }.bind(this), false);
		}
		
		/* the first item should get the close link next to it */
		if(firstLastItem == 'first' || firstLastItem == 'only1') {
			includeCloseLink = true;
			
			aList.className += ' ac_last_suggest';
			
			if(firstLastItem == 'only1'){
				/* make sure it doesn't render the bottom border if it's the only item in the list*/
				firstLastItem = 'last';
			}
		}
		
		/* parse the style of border bottom to all but the last */
		if(firstLastItem != 'last') {
			liList.className = 'ac_li';
		}
		
		/* include the close link and the clear div if needed (*essentially only happens to the first li) */
		if(includeCloseLink) {
			/* don't forget to create the text node. If you instantiate it only on init(), it won't display on
			 * the 2nd or nth times of list display (1st display of list only)
			 */
			 
			this.closeLink.appendChild(document.createTextNode('close'));
			liList.appendChild(this.closeLink);
		}
		
		liList.appendChild(aList);
		
		if(includeCloseLink) 
		{
			liList.appendChild(this.clearDiv)
		}
		
		this.UL.appendChild(liList);
	}
});