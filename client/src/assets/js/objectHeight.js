
function objectHeight(app, elementId){
	var e = document.getElementById(elementId);
	try{
		let d = {elementId: elementId, scrollHeight: e.scrollHeight};
		app.ports.queryObjectHeightResponse.send(d);
	}catch(e){}
}

export default objectHeight;
