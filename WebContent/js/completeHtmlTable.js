function getXMLHttpRequest(){
	var xmlHttpReq = false;
	//XMLHttpRequest object in non IE browser
	if (window.XMLHttpRequest){
		xmlHttpReq = new XMLHttpRequest();
	}else if (window.ActiveXObject){
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return xmlHttpReq;
}

function makeRequest(){
	var xmlHttpRequest = getXMLHttpRequest();
	xmlHttpRequest.onreadyStatechange = getReadyStateHandler(xmlHttpRequest);
	xmlHttpRequest.open("GET", "servletname", true);
	xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttpRequest(null);
}

function getReadyStateHandler(xmlHttpRequest){
	return function(){
		if (xmlHttpRequest.readyState == 4){
			if(xmlHttpRequest.status == 200){
				doccument.getElementById("htmlTable").value = xmlHttpRequest.responseText;
			}else{
				alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText);
			}
		}
	};
}