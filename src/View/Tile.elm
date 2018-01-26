module View.Tile exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Html.Events exposing (onClick)
import Messages exposing (Msg)
import Matrix exposing (Location)
import Game.World exposing (World, Tile)


pixels : Int
pixels =
    10


render : Location -> Tile -> Html Msg
render ( row, col ) tile =
    div
        [ classList
            [ ( "Tile", True )
            , ( toString tile, True )
            ]
        , style
            [ ( "top", (toString (row * pixels)) ++ "px" )
            , ( "left", (toString (col * pixels)) ++ "px" )
            ]
        , onClick (Messages.TileClick ( row, col ) tile)
        ]
        []
