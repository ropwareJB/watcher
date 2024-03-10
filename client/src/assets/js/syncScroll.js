
var ignoreScrollEvents = false;

function syncScroll(from, to){
	to.scrollTop = from.scrollTop;
	to.scrollLeft = from.scrollLeft;
}

function addSyncHandler(ele_a, eles){
	if(ignoreScrollEvents) return;
	ignoreScrollEvents = true;
	for(let i=0;i<eles.length;i++){
		var ele_b = document.getElementById(eles[i]);
		syncScroll(ele_a, ele_b);
	}
	ignoreScrollEvents = false;
}


function syncScrollBidirectional(element1_id, eles_ids) {
	var element1 = document.getElementById(element1_id);
	if(element1 != null){
		element1.onscroll = () => addSyncHandler(element1, eles_ids);
	}
}

window.syncScroll = syncScrollBidirectional;

export default syncScrollBidirectional;
