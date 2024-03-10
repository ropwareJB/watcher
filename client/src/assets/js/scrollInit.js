
function scrollInit(ele_id){
	var ele = document.getElementById(ele_id);
	if(ele != null){
		ele.scrollTo({
			left: (ele.scrollWidth - ele.clientWidth)/2,
			top: 0,
			behavior: 'smooth'
		});
	}
}

window.scrollInit = scrollInit;

export default scrollInit;
