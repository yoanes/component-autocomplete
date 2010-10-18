var AutoComplete = new Class({
	Extends: AutoCompletePrototype,
	
	forceFieldToTop: function() {
	
		/*
		 * See YMB-2248 for more info
		 *  
		  
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
		}
	
		window.scroll(0, textfieldPosY);
				
		*/
		
	}
});