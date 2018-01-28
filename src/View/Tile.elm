module View.Tile exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Html.Events exposing (onClick)
import Messages exposing (Msg)
import Game.World exposing (World, Tile)


size : Int
size =
    10


render : Int -> Int -> Tile -> Html Msg
render x y tile =
    div
        [ classList
            [ ( "Tile", True )
            , ( toString tile, True )
            ]
        , style
            [ ( "top", (toString (y * size)) ++ "px" )
            , ( "left", (toString (x * size)) ++ "px" )
            ]
        , onClick (Messages.TileClick ( x, y ) tile)
        ]
        []
