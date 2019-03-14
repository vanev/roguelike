module View exposing (view)

import Game.World exposing (World)
import Html exposing (Html, div)
import Messages exposing (Msg)
import Model exposing (Model)
import View.Panel exposing (Content(..), Panel, Position, Size, render)
import View.Sidebar
import View.World


worldPanel : World -> Panel
worldPanel world =
    { size = Size 10 10
    , position = Position 0 0
    , content = View.World.content world
    }


sidebarPanel : Model -> Panel
sidebarPanel model =
    { size = Size 5 10
    , position = Position 10 0
    , content = View.Sidebar.content model
    }



-- logPanel : Log -> Panel


mainContent : Model -> Content
mainContent model =
    Node
        [ worldPanel model.world
        , sidebarPanel model

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
