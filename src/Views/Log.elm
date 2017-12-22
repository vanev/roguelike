module Views.Log exposing (panel)

import Game exposing (Game)
import Views.Panel exposing (..)
import Html exposing (text, li, ul)
import List

lineBreak : String
lineBreak = """
"""

-- Displays log of messages. Could be combat info, dialogue, etc.

size : Size
size =
  { width = 15, height = 3 }

position : Position
position =
  { x = 0, y = 10 }

content : Game -> Content
content game =
  game.log.lines
    |> List.map text
    |> List.map List.singleton
    |> List.map (li [])
    |> ul []
    |> Leaf

panel : Game -> Panel
panel game =
  { size = size
  , position = position
  , content = content game
  }
