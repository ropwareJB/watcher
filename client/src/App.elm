module App exposing (Model, init, subscriptions, update, view)

import Browser
import Browser.Dom as Dom
import Browser.Navigation as Navigation
import Dict
import Flags exposing (..)
import Html exposing (..)
import Json.Decode
import Material
import Material.Snackbar as Snackbar
import Model exposing (Model(..))
import Msg exposing (Msg(..))
import Page.Tree
import Ports
import Process
import Task
import Time
import Url exposing (Url)


type alias Model =
    Model.Model Msg


init : Navigation.Key -> Flags -> Url -> ( Model, Cmd Msg )
init key flags url =
    let
        ( modelPageTree, cmdPageTree ) =
            Page.Tree.init PageTreeMsg

        model =
            Model
                { browserKey = key
                , mdc = Material.defaultModel
                , pageTree = modelPageTree

                -- , flags = flags
                -- , subscriptions = []
                }
    in
    ( model
    , Cmd.batch
        [ cmdPageTree
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update message (Model model) =
    case message of
        Mdc msg_ ->
            Tuple.mapFirst Model <| Material.update Mdc msg_ model

        RouteChange url ->
            ( Model model, Cmd.none )

        LinkClicked (Browser.Internal url) ->
            ( Model model, Navigation.pushUrl model.browserKey (Url.toString url) )

        LinkClicked (Browser.External url) ->
            ( Model model, Navigation.load url )

        ChainMsg [] ->
            ( Model model, Cmd.none )

        ChainMsg (x :: xs) ->
            let
                ( model2, cmdUpdate ) =
                    update x (Model model)
            in
            ( model2
            , Cmd.batch
                [ cmdUpdate
                , Task.perform
                    (\_ -> ChainMsg xs)
                    Time.now
                ]
            )

        PageTreeMsg subMsg ->
            Tuple.mapFirst
                (\pageTree -> Model { model | pageTree = pageTree })
            <|
                Page.Tree.update
                    PageTreeMsg
                    model.pageTree
                    subMsg

        NOP ->
            ( Model model, Cmd.none )


type alias ClientHeightData =
    { elementId : String, scrollHeight : Int }


view : Model -> Browser.Document Msg
view model =
    { title = "Watcher"
    , body = [ renderPage model ]
    }


renderPage : Model -> Html Msg
renderPage (Model model) =
    Page.Tree.view PageTreeMsg model.pageTree


subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    Sub.batch
        [-- Ports.queryObjectHeightResponse PortObjectHeightResponse
        ]
