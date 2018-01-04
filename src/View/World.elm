module View.World exposing (content)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Matrix exposing (Matrix)
import Game.World exposing (World, Tile)
import View.Panel exposing (Content(Leaf))
import View.Tile
import View.Object
import View.Item
import View.Creature
import Dict


render : World -> Html Msg
render world =
    let
        heightmap =
            world.heightmap
                |> Matrix.mapWithLocation View.Tile.render
                |> Matrix.toList
                |> List.concatMap identity

        objects =
            world.objects |> Dict.values |> List.map View.Object.render

        items =
            world.items |> Dict.values |> List.map View.Item.render

        creatures =
            world.creatures |> Dict.values |> List.map View.Creature.render

        children =
            heightmap ++ objects ++ items ++ creatures
    in
        div [ class "World" ] children


content : World -> Content
content =
    render >> Leaf
