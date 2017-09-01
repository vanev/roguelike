module Views.Sidebar exposing (panel)

import Models.Game exposing (Game)
import Views.Panel exposing (..)
import Html exposing (text)

-- Displays available actions (movment, inventory, quit, etc.)

size : Size
size =
  { width = 5, height = 10 }

position : Position
position =
  { x = 10, y = 0 }

content : Game -> Content
content game =
  Leaf (text "Sidebar!")

panel : Game -> Panel
panel game =
  { size = size
  , position = position
  , content = content game
  }
