
/* elm-mdc */
/* Sourced from
 * "./../elm-adhoc/elm-mdc/build/elm-mdc.js";
 * "./../elm-adhoc/elm-mdc/build/material-components-web.css";
 */
import "./lib/material/mdc/dynamic/elm-mdc.js";
import "./lib/material/mdc/dynamic/material-components-web.css";

/* Sourced from the following;
 * https://fonts.googleapis.com/icon?family=Material+Icons
 * https://fonts.googleapis.com/css?family=Roboto:300,400,500
 * https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.min.css
 */
import "./lib/material/mdc/material-icons.css";
import "./lib/material/mdc/roboto.css";
import "./lib/material/mdc/normalize.min.css";

/* Clipboard.js */
import Clipboard from 'clipboard/dist/clipboard.min.js';
window.clipboard = new Clipboard('.copy-button');
