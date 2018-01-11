module Physics.Position exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


add : Position -> Position -> Position
add a b =
    Position (a.x + b.x) (a.y + b.y)


map : (Float -> Float) -> Position -> Position
map fn { x, y } =
    Position (fn x) (fn y)


equals : Position -> Position -> Bool
equals a b =
    a.x == b.x && a.y == b.y
