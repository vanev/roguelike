module View.Creature exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Physics.Distance exposing (inFeet)
import Messages exposing (Msg)
import Game.Creature exposing (Creature)


render : Creature -> Html Msg
render creature =
    let
        { x, y } =
            creature.position
    in
        div
            [ classList
                [ ( "Creature", True )
                , ( (toString creature.race), True )
                ]
            , style
                [ ( "top", (toString (inFeet y)) ++ "px" )
                , ( "left", (toString (inFeet x)) ++ "px" )
                ]
            ]
            []
