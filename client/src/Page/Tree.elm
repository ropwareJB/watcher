module Page.Tree exposing (..)

import Html exposing (..)
import Material
import Material.Options as Options exposing (cs, css, id, styled, when)


type alias Lift m =
    Msg m -> m


type alias Root =
    Node


type Node
    = Node
        { active : Bool
        , children : List Node
        }


root : Node
root =
    Node
        { active = False
        , children =
            [ Node { children = [], active = False }
            , Node { children = [], active = False }
            , Node { children = [], active = False }
            ]
        }


type alias Model m =
    { mdc : Material.Model m
    , root : Node
    }


type Msg m
    = Mdc (Material.Msg m)
    | ClickNode Node Root
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
    case msg of
        ClickNode node newRoot ->
            ( { model | root = newRoot }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


view : Lift m -> Model m -> Html m
view lift model =
    Html.div
        []
        [ viewNode lift model (\x -> x) model.root ]


viewNode : Lift m -> Model m -> (Node -> Root) -> Node -> Html m
viewNode lift model updateNode (Node node) =
    let
        node2 =
            Node { node | active = not node.active }
    in
    styled Html.div
        [ css "display" "inline-block" ]
    <|
        [ styled Html.div
            [ cs "node"
            , cs "active" |> when node.active
            , Options.onClick <| lift <| ClickNode node2 <| updateNode node2
            ]
            []
        ]
            ++ List.indexedMap
                (\i child ->
                    viewNode
                        lift
                        model
                        (updateNodeChildrenDeferred updateNode (Node node) i)
                        child
                )
                node.children


updateNodeChildrenDeferred : (Node -> Root) -> Node -> Int -> Node -> Root
updateNodeChildrenDeferred updateNode (Node node) i newChild =
    let
        children2 : List Node
        children2 =
            List.indexedMap
                (\i2 n2 ->
                    case i == i2 of
                        True ->
                            newChild

                        False ->
                            n2
                )
                node.children
    in
    updateNode
        (Node { node | children = children2 })
