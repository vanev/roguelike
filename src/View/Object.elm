module View.Object exposing (render)

import Html exposing (Html, div)
import Messages exposing (Msg)
import Game.Object exposing (Object)


render : Object -> Html Msg
render object =
    div [] []
