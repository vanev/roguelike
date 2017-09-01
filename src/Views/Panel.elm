module Views.Panel exposing (..)

import Messages exposing (Msg)
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import List exposing (repeat, map, map2, indexedMap, foldr)

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

type Content = Leaf (Html Msg)
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
    [ style
      [ ("border", "1px solid black")
      , ("width", (toString (panel.size.width * pixelsPerUnit)) ++ "px")
      , ("height", (toString (panel.size.height * pixelsPerUnit)) ++ "px")
      , ("position", "absolute")
      , ("top", (toString (panel.position.y * pixelsPerUnit)) ++ "px")
      , ("left", (toString (panel.position.x * pixelsPerUnit)) ++ "px")
      ]
    ]
    [ content ]

renderNode : List Panel -> Panel -> Html Msg
renderNode panels panel =
  div
    [ style
      [ ("border", "1px solid black")
      , ("width", (toString (panel.size.width * pixelsPerUnit)) ++ "px")
      , ("height", (toString (panel.size.height * pixelsPerUnit)) ++ "px")
      , ("position", "absolute")
      , ("top", (toString (panel.position.y * pixelsPerUnit)) ++ "px")
      , ("left", (toString (panel.position.x * pixelsPerUnit)) ++ "px")
      ]
    ]
    (map render panels)
