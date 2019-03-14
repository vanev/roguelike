module View.Tile exposing (render, size)

import Game.World exposing (Tile(..), World)
import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Html.Events exposing (onClick)
import Messages exposing (Msg)


size : Int
size =
    10


tileToString : Tile -> String
tileToString tile =
    case tile of
        Dirt ->
            "Dirt"

        Grass ->
            "Grass"


render : Int -> Int -> Tile -> Html Msg
render x y tile =
    div
        [ classList
            [ ( "Tile", True )
            , ( tileToString tile, True )
            ]
        , style "top" (String.fromInt (y * size) ++ "px")
        , style "left" (String.fromInt (x * size) ++ "px")
        , onClick (Messages.TileClick ( x, y ) tile)
        ]
        []
