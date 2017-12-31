module View.World exposing (World, content)

import Html exposing (pre, text)
import Matrix exposing (Matrix)
import Game.World
import View.Panel exposing (Content(Leaf))
import View.Cell exposing (Cell, toCell)
import View.Symbols exposing (blank, lineBreak)

type alias World =
  Matrix Cell

toWorld : Game.World.World -> World
toWorld gameWorld =
  gameWorld
    |> .heightmap
    |> Matrix.mapWithLocation (toCell gameWorld)

toString : World -> String
toString world =
  Matrix.map View.Cell.toString world
    |> Matrix.toList
    |> List.map (String.join blank)
    |> String.join lineBreak

content : Game.World.World -> Content
content gameWorld =
  toWorld gameWorld
    |> toString
    |> text
    |> List.singleton
    |> pre []
    |> Leaf
