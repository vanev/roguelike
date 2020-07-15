module View.World exposing (content)

import Array
import Dict
import Game.World exposing (World)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Matrix
import Messages exposing (Msg)
import View.Creature
import View.Item
import View.Object
import View.Panel exposing (Content(..))
import View.Tile


render : World -> Html Msg
render world =
    let
        heightmap =
            world.heightmap
                |> Matrix.indexedMap View.Tile.render
                |> Matrix.toIndexedArray
                |> Array.toList
                |> List.map Tuple.second

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
