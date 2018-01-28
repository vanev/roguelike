module View.Creature exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Messages exposing (Msg)
import Game.Creature exposing (Creature)
import Matrix.Point
import View.Tile


render : Creature -> Html Msg
render creature =
    let
        ( x, y ) =
            Matrix.Point.fromPosition creature.position
    in
        div
            [ classList
                [ ( "Creature", True )
                , ( (toString creature.race), True )
                ]
            , style
                [ ( "top", (toString (y * View.Tile.size)) ++ "px" )
                , ( "left", (toString (x * View.Tile.size)) ++ "px" )
                ]
            ]
            []
