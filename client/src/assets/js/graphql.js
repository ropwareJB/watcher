import * as AbsintheSocket from "@absinthe/socket";
import { Socket as PhoenixSocket } from "phoenix";

let notifiers = [];

class GraphQLSocket{

	constructor(app){
		this.socket = null;
		this.app = app;
		this.__subs = []
	}

	connect(wss_url, wsToken){
		// console.log("Connecting to socket " + wss_url);
		this.socket = AbsintheSocket.create(
			new PhoenixSocket(wss_url, {params: {userToken: wsToken}})
		);
		while(this.__subs.length > 0){
			let sub = this.__subs.pop();
			// console.log("subbing to " + sub)
			this.__subscribe(sub);
		}

	}

	subscribe(sub){
		// console.log(sub);
		// console.log(this.socket);
		if(this.socket == null) this.__subs.push(sub);
		else this.__subscribe(sub);
	}

	__subscribe(sub){
		// Remove existing notifiers
		// notifiers.map(notifier => AbsintheSocket.cancel(this.socket, notifier));

		// Create new notifiers for each subscription sent
		notifiers = [sub].map(operation =>
			AbsintheSocket.send(this.socket, {
				operation,
				variables: {}
			})
		);

		let onStart = (data) => {
			// console.log(">>> Start", JSON.stringify(data));
			this.app.ports.gqlConnected.send(null);
		}

		let onAbort = (data) => {
			// console.log(">>> Abort", JSON.stringify(data));
		}

		let onCancel = (data) => {
			// console.log(">>> Cancel", JSON.stringify(data));
		}

		let onError = (data) => {
			// console.log(">>> Error", JSON.stringify(data));
			this.app.ports.gqlReconnecting.send(null);
		}

		let onResult = (res) => {
			// console.log(">>> Result", JSON.stringify(res));
			this.app.ports.gqlSubscriptionRecv.send(res);
		}

		notifiers.map(notifier =>
			AbsintheSocket.observe(this.socket, notifier, {
				onAbort,
				onError,
				onCancel,
				onStart,
				onResult
			})
		);
	}
}

export function init(app, wss_url){
	let sock = new GraphQLSocket(app);

	app.ports.gqlSubscribe.subscribe( (subscription) => {
		// console.log("createSubscriptions called with", [subscription]);
		sock.subscribe(subscription);
	});
	app.ports.gqlInit.subscribe( (ws_token) => {
		sock.connect(wss_url, ws_token);
	});
}


export default init
