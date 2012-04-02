/* 	
	$('searchsubject').observe('onchange()',autosubject(3));
	$('searchtitle').observe('onchange()',autotitle(3));
	$('searchtype').observe('onchange()',autotype(2));
	$('searchbranch').observe('onchange()',autobranch(2));
	$('searchage').observe('onchange()',autoage(1));
*/

//all 5 autocompleter functions are note used
//additional parameters are requested using ?parametername=value&....&....
function autosubject(minchars, action){
	new Ajax.Autocompleter("searchsubject", "autosubject_div", "searchToolAutocomplete.jsp?parametername=value",{
		minChars: minchars,
		indicator:"loadingautocomplete"//Id of whileloading the data
	});
	console.log($('autosubject_div'));//DOM or Console log in Firebug
};
function autotitle(minchars){
	new Ajax.Autocompleter("searchtitle", "autotitle_div", "searchToolAutocomplete.jsp",{
		minChars: minchars
	});
};
function autotype(minchars){
	new Ajax.Autocompleter("searchtype", "autotype_div", "searchToolAutocomplete.jsp",{
		minChars: minchars 
	});
};
function autobranch(minchars){
	new Ajax.Autocompleter("searchbranch", "autobranch_div", "searchToolAutocomplete.jsp",{
		minChars: minchars 
	});
};
function autoage(minchars){
	new Ajax.Autocompleter("searchage", "autoage_div", "searchToolAutocomplete.jsp",{
		minChars: minchars
	});	
};

//Ajax call for the Search on searchTools.jsp page Form id = "searchToolForm"
function searchresult(event){
	Event.stop(event); 
	new Ajax.Request('searchResults.jsp',
	{
	  //method:'get', //default POST
	  parameters: Form.serialize("searchToolForm"), //serialize make GET request easy to understand
	  onSuccess: function(transport){
			    $('search_result').update(transport.responseText);
	  		},
	  onLoading: function () {  
                $('search_result').update( '<img src="images/loading-bar.gif" title="Loading... alt="Loading...""/><br />');  
            }, 
	  onFailure: function(transport){ 
            	$('search_result').update(transport.statusText);
		  }
	});
}
/*@author anshul meena
 * For the button ajax callback and innerhtml update 
 * we can also use new Ajax.Updater() constructor 
 * 
 *  http://www.sergiopereira.com/articles/prototype.js.html
 * 
 */
function addtocart(url){
	function findID(url){
		var addstart = url.lastIndexOf("=");
		var addrowid = url.substring(addstart+1);
		return(addrowid);
	};
	new Ajax.Request(url, {
		method: 'get',
		onLoading: function () {
			var addeleid = findID(url);
			addtrid = "button"+addeleid;
			$(addtrid).update('<img src="images/spinner-circles-green.gif" title="Loading..." alt="Loading..."/>');  
		}, 
		onComplete: function(transport) {
			var addeleid = findID(url);
			addtrid = "button"+addeleid;
			$(addtrid).replace('<button id="'+addtrid+'" onclick="removefromcart(\'addtocart.jsp?action=remove&rowid='+addeleid+'\');">Remove</button>');
			$(addtrid).innerHTML;
			$('cartItem_count').update(transport.responseText);
		}
	});
}
function removefromcart(url){
	function findID(url){
		var removestart = url.lastIndexOf("=");
		var removerowid = url.substring(removestart+1);
		return(removerowid);
	};
	new Ajax.Request(url, {
		method: 'get',
		onLoading: function () {  
			var remoceleid = findID(url);
			removetrid = "button"+remoceleid;
			//Prototype accept ID for $('') function with no Quot's eg. id = "ans123" //-> $(id)
			$(removetrid).update('<img src="images/spinner-circles-green.gif" title="Loading... alt="Loading...""/>');
		}, 
		onComplete: function(transport) {
			var remoceleid = findID(url);//ID given with no single quot's
			removetrid = "button"+remoceleid;
			$(removetrid).replace('<button id="'+removetrid+'" onclick="addtocart(\'addtocart.jsp?action=add&rowid='+remoceleid+'\');">Add to Cart</button>');
			$(removetrid).innerHTML;
			$('cartItem_count').update(transport.responseText);
		}
	});
}

function archive_option(){
	var value = $F('archive_select');
	var pars = "value="+value;
	var myAjax = new Ajax.Request('history.jsp',
	{
		method:'get',
		parameters: pars, 
		onLoading: function () {  
			$('dataTable').update( '<img src="images/loading-bar.gif" title="Loading... alt="Loading...""/><br />');  
		},
		onComplete: function(xhr){
			$('dataTable').update(xhr.responseText);
		},
		onFailure: function(xhr){ 
			$('dataTable').update(xhr.statusText);
		}
	});
}

