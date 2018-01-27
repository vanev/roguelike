module View.Object exposing (render)

import Html exposing (Html, div)
import Html.Attributes exposing (classList, style)
import Messages exposing (Msg)
import Game.Object exposing (Object)


render : Object -> Html Msg
render object =
    let
        ( row, col ) =
            object.location
    in
        div
            [ classList
                [ ( "Object", True )
                , ( (toString object.kind), True )
                ]
            , style
                [ ( "top", (toString (row * 10)) ++ "px" )
                , ( "left", (toString (col * 10)) ++ "px" )
                ]
            ]
            []
