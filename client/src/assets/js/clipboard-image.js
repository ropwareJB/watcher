
export function init(app){
	window.addEventListener("paste", (pasteEvent) => {
		var items = pasteEvent.clipboardData.items;

		for (var i = 0; i < items.length; i++) {
			var item = items[i];
			if (item.type.indexOf("image") == -1) continue;

			// Retrieve image on clipboard as blob
			var blob = item.getAsFile();

			// Create an abstract canvas and get context
			var mycanvas = document.createElement("canvas");
			var ctx = mycanvas.getContext('2d');
			
			// Create an image
			var img = new Image();

			// Once the image loads, render the img on the canvas
			img.onload = function(){
				// Update dimensions of the canvas with the dimensions of the image
				mycanvas.width = this.width;
				mycanvas.height = this.height;

				// Draw the image
				ctx.drawImage(img, 0, 0);

				let dataURL = mycanvas.toDataURL("image/png");
				app.ports.clipboardPasteImage.send(dataURL)
			};

			// Crossbrowser support for URL
			var URLObj = window.URL || window.webkitURL;

			// Creates a DOMString containing a URL representing the object given in the parameter
			// namely the original Blob
			img.src = URLObj.createObjectURL(blob);
		}
	}, false);
}

export default init;
