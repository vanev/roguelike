module View exposing (..)

import Models.Game exposing (..)
import Html exposing (Html, div, text)
import Messages exposing (Msg)

view : Game -> Html Msg
view game =
  div []
      [ text game ]
