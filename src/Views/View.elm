module Views.View exposing (..)

import Models.Game exposing (Game)
import Views.Main exposing (panel)
import Views.Panel exposing (render)
import Messages exposing (Msg)
import Html exposing (Html, div)

display : Game -> Html Msg
display game =
  panel game
    |> render

view : Game -> Html Msg
view game =
  div []
      [ display game ]
