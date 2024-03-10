import { Elm } from './Main.elm';
// import registerServiceWorker from './assets/js/registerServiceWorker.js';

import "./shared-deps/index.js"

import "@webcomponents/webcomponentsjs/custom-elements-es5-adapter.js"
import "@webcomponents/webcomponentsjs/webcomponents-loader.js"
import Chart from "chart.js/dist/chart.min.js"
import "@ropwareJB/elm-chartjs-webcomponent/webcomponent/chart.js"

import initGraphQL from './assets/js/graphql.js';
import clearSelection from './assets/js/clearSelection.js';
import clipboardImage from './assets/js/clipboard-image.js';
import syncScroll from './assets/js/syncScroll.js';
import scrollInit from './assets/js/scrollInit.js';
import objectHeight from './assets/js/objectHeight.js';
import './assets/css/main.css';
import './assets/css/datepicker.css';

var apiEndpoint = process.env.ELM_APP_API_ENDPOINT;
var wsEndpoint = process.env.ELM_APP_API_WS;
if(process.env.ELM_APP_LOCAL_ENV != "true"){
	apiEndpoint = "https://" + window.location.host;
	wsEndpoint = "wss://" + window.location.host + "/socket";
}

let getCsrf = () => {
	// if(process.env.ELM_APP_LOCAL_ENV != "true"){
	// 	let csrfToken = document.head.querySelector("[name~=csrf-token][content]").content;
	// 	return Promise.resolve(csrfToken);
	// }else{
	// 	return fetch(`${apiEndpoint}/api/auth/csrf`, {
	// 		credentials: 'include'
	// 	})
	// 		.then(val => val.json())
	// 		.then(data => data.csrf)
	// }
	return Promise.resolve("AAAAA");
}

addEventListener('WebComponentsReady', () => {
// addEventListener('load', () => {
	document.body.classList.remove('notDefined');
	getCsrf()
		.then(csrfToken => {
			var app = Elm.Main.init({
				node: document.getElementById('root'),
				flags: {
					apiEndpoint: apiEndpoint,
					csrf: csrfToken
				}
			});

			// initGraphQL(app, wsEndpoint);
			// clipboardImage(app);

			/* Used with norpan/elm-html5-drag-drop */
			// app.ports.dragStart.subscribe(function (event) {
			// 	event.dataTransfer.setData('text', '');
			// });

			// app.ports.clearSelection.subscribe( () => {
			// 	clearSelection();
			// });

			// app.ports.syncScroll.subscribe( (eles) => {
			// 	let eleA = eles.shift()
			// 	syncScroll(eleA, eles);
			// });

			// app.ports.scrollInit.subscribe( (ele_id) => {
			// 	scrollInit(ele_id);
			// });

			// app.ports.queryObjectHeight.subscribe( (elementId) => {
			// 	objectHeight(app, elementId);
			// });

		})
})
