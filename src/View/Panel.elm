module View.Panel exposing (Content(..), Panel, Position, Size, render)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import List exposing (map)
import Messages exposing (Msg)


pixelsPerUnit : Int
pixelsPerUnit =
    50


type alias Position =
    { x : Int
    , y : Int
    }


type alias Size =
    { width : Int
    , height : Int
    }


type Content
    = Leaf (Html Msg)
    | Node (List Panel)


type alias Panel =
    { size : Size
    , position : Position
    , content : Content
    }


render : Panel -> Html Msg
render panel =
    case panel.content of
        Leaf content ->
            renderLeaf content panel

        Node panels ->
            renderNode panels panel


renderLeaf : Html Msg -> Panel -> Html Msg
renderLeaf content panel =
    div
        [ style "border" "1px solid black"
        , style "width" (String.fromInt (panel.size.width * pixelsPerUnit) ++ "px")
        , style "height" (String.fromInt (panel.size.height * pixelsPerUnit) ++ "px")
        , style "position" "absolute"
        , style "top" (String.fromInt (panel.position.y * pixelsPerUnit) ++ "px")
        , style "left" (String.fromInt (panel.position.x * pixelsPerUnit) ++ "px")
        ]
        [ content ]


renderNode : List Panel -> Panel -> Html Msg
renderNode panels panel =
    div
        [ style "border" "1px solid black"
        , style "width" (String.fromInt (panel.size.width * pixelsPerUnit) ++ "px")
        , style "height" (String.fromInt (panel.size.height * pixelsPerUnit) ++ "px")
        , style "position" "absolute"
        , style "top" (String.fromInt (panel.position.y * pixelsPerUnit) ++ "px")
        , style "left" (String.fromInt (panel.position.x * pixelsPerUnit) ++ "px")
        ]
        (map render panels)
