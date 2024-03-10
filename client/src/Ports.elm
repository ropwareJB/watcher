port module Ports exposing (clearSelection, clipboardPasteImage, dragStart, gqlConnected, gqlInit, gqlReconnecting, gqlSubscribe, gqlSubscriptionRecv, queryObjectHeight, queryObjectHeightResponse, scrollInit, syncScroll)

import Json.Decode
import Vega


port gqlSubscribe : String -> Cmd msg


port gqlSubscriptionRecv : (Json.Decode.Value -> msg) -> Sub msg


port gqlConnected : (() -> msg) -> Sub msg


port gqlReconnecting : (() -> msg) -> Sub msg


port gqlInit : String -> Cmd msg


port dragStart : Json.Decode.Value -> Cmd msg


port toVega : Vega.Spec -> Cmd msg


port clipboardPasteImage : (Json.Decode.Value -> msg) -> Sub msg


port clearSelection : () -> Cmd msg


port syncScroll : List String -> Cmd msg


port scrollInit : String -> Cmd msg


port queryObjectHeight : String -> Cmd msg


port queryObjectHeightResponse : (Json.Decode.Value -> msg) -> Sub msg
