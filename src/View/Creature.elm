module View.Creature exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Messages exposing (Msg)
import Game.Creature exposing (Creature)


render : Creature -> Html Msg
render creature =
    let
        ( row, col ) =
            creature.location
    in
        div
            [ classList
                [ ( "Creature", True )
                , ( (toString creature.race), True )
                ]
            , style
                [ ( "top", (toString (row * 10)) ++ "px" )
                , ( "left", (toString (col * 10)) ++ "px" )
                ]
            ]
            []
