var AutoComplete = new Class({
	Extends: AutoCompletePrototype,
	
	forceFieldToTop: function() {
		window.scroll(0, $(this.observe).offsetTop);
	}
});