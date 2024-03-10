module Page.Tree exposing (..)

import Html exposing (..)
import Material
import Material.Options as Options exposing (cs, css, id, styled, when)


type alias Lift m =
    Msg m -> m


type Node
    = Node { children : List Node }


root : Node
root =
    Node
        { children =
            [ Node { children = [] }
            , Node { children = [] }
            , Node { children = [] }
            ]
        }


type alias Model m =
    { mdc : Material.Model m
    , root : Node
    }


type Msg m
    = Mdc (Material.Msg m)
    | NOP


init : Lift m -> ( Model m, Cmd m )
init lift =
    ( { mdc = Material.defaultModel
      , root = root
      }
    , Cmd.none
    )


update : Lift m -> Model m -> Msg m -> ( Model m, Cmd m )
update lift model msg =
    ( model, Cmd.none )


view : Model m -> Html m
view model =
    Html.div
        []
        [ viewNode model.root ]


viewNode : Node -> Html m
viewNode (Node node) =
    styled Html.div
        [ css "display" "inline-block" ]
    <|
        [ styled Html.div
            [ cs "node" ]
            []
        ]
            ++ List.map viewNode node.children
