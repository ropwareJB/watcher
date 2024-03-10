module Msg exposing (Msg(..))

import Browser
import Http
import Json.Decode
import Material
import Page.Tree
import Url exposing (Url)


type Msg
    = Mdc (Material.Msg Msg)
    | ChainMsg (List Msg)
    | PageTreeMsg (Page.Tree.Msg Msg)
    | LinkClicked Browser.UrlRequest
    | RouteChange Url
    | NOP
