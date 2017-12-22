module Views.Main exposing (..)

import Game exposing (Game)
import Views.Panel exposing (..)
import Views.World
import Views.Sidebar
import Views.Log

size : Size
size =
  { width = 15, height = 13 }

position : Position
position =
  { x = 0, y = 0 }

content : Game -> Content
content game =
  Node [ Views.World.panel game
       , Views.Sidebar.panel game
       , Views.Log.panel game
       ]

panel : Game -> Panel
panel game =
  { size = size
  , position = position
  , content = content game
  }
