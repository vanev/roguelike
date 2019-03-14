module View.Object exposing (render)

import Game.Object exposing (Kind(..), Object)
import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Matrix.Point
import Messages exposing (Msg)
import View.Tile


kindToString : Kind -> String
kindToString kind =
    case kind of
        Door material ->
            "Door"

        Wall material ->
            "Wall"


render : Object -> Html Msg
render object =
    let
        ( x, y ) =
            Matrix.Point.fromPosition object.position
    in
    div
        [ classList
            [ ( "Object", True )
            , ( kindToString object.kind, True )
            ]
        , style "top" (String.fromInt (y * View.Tile.size) ++ "px")
        , style "left" (String.fromInt (x * View.Tile.size) ++ "px")
        ]
        []
