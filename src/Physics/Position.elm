module Physics.Position exposing (..)

type alias Position =
  { x : Float
  , y : Float
  }

add : Position -> Position -> Position
add a b =
  Position (a.x + b.x) (a.y + b.y)
