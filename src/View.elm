module View exposing (..)

import Model exposing (..)
import Html exposing (Html, div, text)
import Messages exposing (Msg)

view : Model -> Html Msg
view model =
  div []
      [ text model ]
