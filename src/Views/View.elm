module Views.View exposing (..)

import Game exposing (Game)
import Model exposing (Model)
import Views.Main exposing (panel)
import Views.Panel exposing (render)
import Messages exposing (Msg)
import Html exposing (Html, div)

display : Game -> Html Msg
display game =
  panel game
    |> render

view : Model -> Html Msg
view model =
  div []
      [ display model.game ]
