module View.Creature exposing (render)

import Game.Creature exposing (Creature, Race(..))
import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Matrix.Point
import Messages exposing (Msg)
import View.Tile


raceToString : Race -> String
raceToString race =
    case race of
        Human ->
            "Human"

        Goblin ->
            "Goblin"


render : Creature -> Html Msg
render creature =
    let
        ( x, y ) =
            Matrix.Point.fromPosition creature.position
    in
    div
        [ classList
            [ ( "Creature", True )
            , ( raceToString creature.race, True )
            ]
        , style "top" (String.fromInt (y * View.Tile.size) ++ "px")
        , style "left" (String.fromInt (x * View.Tile.size) ++ "px")
        ]
        []
