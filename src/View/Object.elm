module View.Object exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Messages exposing (Msg)
import Game.Object exposing (Object)
import Matrix.Point
import View.Tile


render : Object -> Html Msg
render object =
    let
        ( x, y ) =
            Matrix.Point.fromPosition object.position
    in
        div
            [ classList
                [ ( "Object", True )
                , ( (toString object.kind), True )
                ]
            , style
                [ ( "top", (toString (y * View.Tile.size)) ++ "px" )
                , ( "left", (toString (x * View.Tile.size)) ++ "px" )
                ]
            ]
            []
