var AutoComplete = new Class({
	Extends: AutoCompletePrototype,
	
	forceFieldToTop: function() {
	
		var textfieldPosY = $(this.observe).offsetTop; 
	
		try
		{
			for (var i = 0; i < ADVANCETEXTFIELD.instances.length; i ++)
			{
				if (ADVANCETEXTFIELD.instances[i].inputId == this.observe)
				{
					textfieldPosY = $(this.observe).offsetParent.offsetTop;
					break;
				}
			}
			
		}
		catch(e)
		{
			/* No match, advance textfields aren't being used */
		}
	
		window.scroll(0, textfieldPosY);
	}
});