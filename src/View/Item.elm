module View.Item exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Messages exposing (Msg)
import Game.Item exposing (Item)


render : Item -> Html Msg
render object =
    div [] []
