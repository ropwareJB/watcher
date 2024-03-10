module Page.Tree exposing (..)

import Html exposing (..)
import Material


type alias Lift m =
    Msg m -> m


type alias Model m =
    { mdc : Material.Model m }


type Msg m
    = Mdc (Material.Msg m)
    | NOP


init : Lift m -> ( Model m, Cmd m )
init lift =
    ( { mdc = Material.defaultModel }
    , Cmd.none
    )


update : Lift m -> Model m -> Msg m -> ( Model m, Cmd m )
update lift model msg =
    ( model, Cmd.none )


view : Model m -> Html m
view model =
    Html.div
        []
        [ text "yeobuseyo" ]
