module Views.Sidebar exposing (panel)

import Views.Panel exposing (..)
import Game exposing (Game)
import Action exposing (toSidebarString)
import Action.Index exposing (availableActions)
import Html exposing (text, li, ul)
import List exposing (map, singleton)

-- Displays available actions (movment, inventory, quit, etc.)

size : Size
size =
  { width = 5, height = 10 }

position : Position
position =
  { x = 10, y = 0 }

content : Game -> Content
content game =
  availableActions game
    |> map toSidebarString
    |> map text
    |> map singleton
    |> map (li [])
    |> ul []
    |> Leaf

panel : Game -> Panel
panel game =
  { size = size
  , position = position
  , content = content game
  }
