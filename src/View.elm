module View exposing (view)

import Model exposing (Model)
import Game.World exposing (World)
-- import Game.Log exposing (Log)
import View.Panel exposing (Panel, Size, Position, Content(Node), render)
import View.World
import Messages exposing (Msg)
import Html exposing (Html, div)

worldPanel : World -> Panel
worldPanel world =
  { size = Size 10 10
  , position = Position 0 0
  , content = View.World.content world
  }

-- sidebarPanel : Model -> Panel

-- logPanel : Log -> Panel

mainContent : Model -> Content
mainContent model =
  Node
    [ worldPanel model.world
    -- , sidebarPanel model
    -- , logPanel model.log
    ]

mainPanel : Model -> Panel
mainPanel model =
  { size = Size 15 13
  , position = Position 0 0
  , content = mainContent model
  }

view : Model -> Html Msg
view model =
  div []
      [ (render << mainPanel) model ]
