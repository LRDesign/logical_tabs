/**
 * Javascript code to support switching, memorizing, and preselecting
 * tabs in a tabbed_panel structure for the plugin logical_tabs.
 * 
 * NOTE: Includes a full copy of CookieJar by Lalit Patel, see below.
 * 
 * Author : Evan Dorn
 * Website: http://lrdesign.com/tools
 * License: MIT License, see included LICENSE file.
 * Version: 1.0
 * Updated: April 22, 2010
 * 
 */   
  
// Set up the observer on the tabs, and 
window.onload = function() {
	$$('.tabbed_panel li.tab a.tab_link').invoke('observe', 'click', handle_tab_click);  	  
	$$('.tabbed_panel').each(function(item, index){ pre_select_tab(item)});
}           
 
// Given a tabbed_panel div element, checks to see if there's a pre-stored
// tab association.  If there is, select that tab.                                                                        
function pre_select_tab(tabbed_panel) {
    tab_memory = get_tab_memory();
    tab_id = tab_memory[memory_key_from_tabbed_panel(tabbed_panel.identify())]  
    if(tab_id != null) {
      select_tab(tab_id);
    }
}                                                 

// Select a tab that's been clicked on and store that preference in a cookie.
function handle_tab_click(event) {  
	tab_id = Event.element(event).up().identify();
  select_tab(tab_id);    
  store_tab_preference(tab_id);
}        

// Handle the display changes necessary for selecting a new tab.
// iterate the tabs of the parent tabbed_panel and set them and their panes
// selected or not based on whether they match the clicked-on
// tab.
function select_tab(tab_id) {
	$(get_tabbed_panel_id(tab_id)).select('li.tab').each(function(tab, index){				
		pane_id = tab.identify().replace(/_tab$/,"_pane");
		pane = $(pane_id);
		if(tab.identify() == tab_id) {
			tab.removeClassName('tab_unselected');
			tab.addClassName('tab_selected');
			pane.removeClassName('pane_unselected');
			pane.addClassName('pane_selected');			
		} else {
			tab.removeClassName('tab_selected');
			tab.addClassName('tab_unselected');
			pane.removeClassName('pane_selected');
			pane.addClassName('pane_unselected');			
		}
	});
}                            

// extract the containing tabbed panel's ID from the tab's ID
function get_tabbed_panel_id(tab_id) {
	return tab_id.substring(0, tab_id.indexOf("_tp_"));  
}            
                
// Generate the key associated with this page's path and this tabbed_panel,
// starting from the id of an individual tab.
function memory_key_from_tab(tab_id) {
  return (location.pathname + "--" + get_tabbed_panel_id(tab_id)).replace(/^\//,'')
}                           

// Generate the key associated with this page's path and this tabbed_panel,
// starting from the id of the tabbed panel.
function memory_key_from_tabbed_panel(tabbed_panel_id) {
  return (location.pathname + "--" + tabbed_panel_id).replace(/^\//,'')  
}

// Store which tab was selected for this URL and tabbed panel combination
function store_tab_preference(tab_id) {  
  tab_memory = get_tab_memory();
  if (tab_memory == null) {
    tab_memory = new Object();
  }
  tab_memory[memory_key_from_tab(tab_id)] = tab_id;
  tab_memory_cookie.put('tab_memory', tab_memory);
}
  
// Retrieve the array of memorized tabs from the cookie.
function get_tab_memory() {
  return tab_memory_cookie.get('tab_memory');
}


/**
 * Javascript code to store data as JSON strings in cookies. 
 * It uses prototype.js 1.5.1 (http://www.prototypejs.org)
 * 
 * Author : Lalit Patel
 * Website: http://www.lalit.org/lab/jsoncookies
 * License: Apache Software License 2
 *          http://www.apache.org/licenses/LICENSE-2.0
 * Version: 0.5
 * Updated: Jan 26, 2009 
 * 
 * Chnage Log:
 *   v 0.5
 *   -  Changed License from CC to Apache 2
 *   v 0.4
 *   -  Removed a extra comma in options (was breaking in IE and Opera). (Thanks Jason)
 *   -  Removed the parameter name from the initialize function
 *   -  Changed the way expires date was being calculated. (Thanks David)
 *   v 0.3
 *   -  Removed dependancy on json.js (http://www.json.org/json.js)
 *   -  empty() function only deletes the cookies set by CookieJar
 */

var CookieJar = Class.create();

CookieJar.prototype = {

	/**
	 * Append before all cookie names to differntiate them.
	 */
	appendString: "__CJ_",

	/**
	 * Initializes the cookie jar with the options.
	 */
	initialize: function(options) {
		this.options = {
			expires: 3600,		// seconds (1 hr)
			path: '',			// cookie path
			domain: '',			// cookie domain
			secure: ''			// secure ?
		};
		Object.extend(this.options, options || {});

		if (this.options.expires != '') {
			var date = new Date();
			date = new Date(date.getTime() + (this.options.expires * 1000));
			this.options.expires = '; expires=' + date.toGMTString();
		}
		if (this.options.path != '') {
			this.options.path = '; path=' + escape(this.options.path);
		}
		if (this.options.domain != '') {
			this.options.domain = '; domain=' + escape(this.options.domain);
		}
		if (this.options.secure == 'secure') {
			this.options.secure = '; secure';
		} else {
			this.options.secure = '';
		}
	},

	/**
	 * Adds a name values pair.
	 */
	put: function(name, value) {
		name = this.appendString + name;
		cookie = this.options;
		var type = typeof value;
		switch(type) {
		  case 'undefined':
		  case 'function' :
		  case 'unknown'  : return false;
		  case 'boolean'  : 
		  case 'string'   : 
		  case 'number'   : value = String(value.toString());
		}
		var cookie_str = name + "=" + escape(Object.toJSON(value));
		try {
			document.cookie = cookie_str + cookie.expires + cookie.path + cookie.domain + cookie.secure;
		} catch (e) {
			return false;
		}
		return true;
	},

	/**
	 * Removes a particular cookie (name value pair) form the Cookie Jar.
	 */
	remove: function(name) {
		name = this.appendString + name;
		cookie = this.options;
		try {
			var date = new Date();
			date.setTime(date.getTime() - (3600 * 1000));
			var expires = '; expires=' + date.toGMTString();
			document.cookie = name + "=" + expires + cookie.path + cookie.domain + cookie.secure;
		} catch (e) {
			return false;
		}
		return true;
	},

	/**
	 * Return a particular cookie by name;
	 */
	get: function(name) {
		name = this.appendString + name;
		var cookies = document.cookie.match(name + '=(.*?)(;|$)');
		if (cookies) {
			return (unescape(cookies[1])).evalJSON();
		} else {
			return null;
		}
	},

	/**
	 * Empties the Cookie Jar. Deletes all the cookies.
	 */
	empty: function() {
		keys = this.getKeys();
		size = keys.size();
		for(i=0; i<size; i++) {
			this.remove(keys[i]);
		}
	},

	/**
	 * Returns all cookies as a single object
	 */
	getPack: function() {
		pack = {};
		keys = this.getKeys();

		size = keys.size();
		for(i=0; i<size; i++) {
			pack[keys[i]] = this.get(keys[i]);
		}
		return pack;
	},

	/**
	 * Returns all keys.
	 */
	getKeys: function() {
		keys = $A();
		keyRe= /[^=; ]+(?=\=)/g;
		str  = document.cookie;
		CJRe = new RegExp("^" + this.appendString);
		while((match = keyRe.exec(str)) != undefined) {
			if (CJRe.test(match[0].strip())) {
				keys.push(match[0].strip().gsub("^" + this.appendString,""));
			}
		}
		return keys;
	}
};

// set up tab memory cookie
tab_memory_cookie = new CookieJar({
  expires: 3600 * 24 * 365,  // one year
  path: '/',
  name: 'tab_memory'	  
})
