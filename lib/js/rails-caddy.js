var RailsCaddy = {

  isExtended: 0,

  slideSideBar: function() {

  	new Effect.toggle('railsCaddyContents', 'blind', {scaleX: 'true', scaleY: 'true;', scaleContent: false});
	
  	if (RailsCaddy.isExtended == 0) {
  		$('railsCaddyTab').childNodes[0].src = $('railsCaddyTab').childNodes[0].src.replace(/(\.[^.]+)$/, '-active$1');
		
  		new Effect.Fade('railsCaddyContents', { duration:1.0, from:0.0, to:1.0 });
		
  		RailsCaddy.isExtended++;
  	}
  	else {
  		$('railsCaddyTab').childNodes[0].src = $('railsCaddyTab').childNodes[0].src.replace(/-active(\.[^.]+)$/, '$1');
		
  		new Effect.Fade('railsCaddyContents', { duration:1.0, from:1.0, to:0.0 });
		
  		RailsCaddy.isExtended=0;
  	}
	
  },

  init: function() {
  	Event.observe('railsCaddyTab', 'click', RailsCaddy.slideSideBar, true);
  },
  
  scroll: function() {
    $('railsCaddy').style.top = (window.scrollY + 100) + "px";
  }
};

Event.observe(window, 'load',   RailsCaddy.init,  true);
Event.observe(window, 'scroll', RailsCaddy.scroll, true)