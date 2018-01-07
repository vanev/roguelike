module View.Item exposing (render)

import Html exposing (Html, div)
import Messages exposing (Msg)
import Game.Item exposing (Item)


render : Item -> Html Msg
render object =
    div [] []
