module Main exposing (main)

import App
import Browser
import Browser.Navigation as Navigation
import Flags exposing (Flags)
import Model exposing (Model)
import Msg exposing (Msg)
import Url exposing (Url)


init : Flags -> Url -> Navigation.Key -> ( App.Model, Cmd Msg )
init flags url key =
    App.init key flags url


main : Program Flags (Model Msg) Msg
main =
    Browser.application
        { init = init
        , update = App.update
        , view = App.view
        , subscriptions = App.subscriptions
        , onUrlChange = Msg.RouteChange
        , onUrlRequest = Msg.LinkClicked
        }
