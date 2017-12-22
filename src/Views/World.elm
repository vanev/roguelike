module Views.World exposing (panel)

import Game exposing (Game)
import Views.Panel exposing (..)
import Html exposing (text, pre)
import Views.World.World

-- Displays the view of the world, centered around player's location.

size : Size
size =
  { width = 10, height = 10 }

position : Position
position =
  { x = 0, y = 0 }

content : Game -> Content
content game =
  Views.World.World.toWorld game
    |> Views.World.World.toString
    |> text
    |> List.singleton
    |> pre []
    |> Leaf

panel : Game -> Panel
panel game =
  { size = size
  , position = position
  , content = content game
  }
