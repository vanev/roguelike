module Views.Log exposing (panel)

import Models.Game exposing (Game)
import Views.Panel exposing (..)
import Html exposing (text)

-- Displays log of messages. Could be combat info, dialogue, etc.

size : Size
size =
  { width = 15, height = 3 }

position : Position
position =
  { x = 0, y = 10 }

content : Game -> Content
content game =
  Leaf (text "Log!")

panel : Game -> Panel
panel game =
  { size = size
  , position = position
  , content = content game
  }
