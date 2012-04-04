/*@author anshul meena
 * For the button ajax callback and innerhtml update 
 * we can also use new Ajax.Updater() constructor 
 * 
 *  http://www.sergiopereira.com/articles/prototype.js.html
 * 
 */
function approveOrder(url){
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
			$(addtrid).replace('<button id="'+addtrid+'" onclick="disApproveOrder(\'approveOrder.jsp?action=approce&ID='+addeleid+'\');">Disapprove</button>');
			$(addtrid).innerHTML;
			$('cartItem_count').update(transport.responseText);
		}
	});
}
function disApproveOrder(url){
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
			$(removetrid).replace('<button id="'+removetrid+'" onclick="approveOrder(\'approveOrder.jsp?action=disapprove&ID='+remoceleid+'\');">Approve</button>');
			$(removetrid).innerHTML;
			$('cartItem_count').update(transport.responseText);
		}
	});
}


