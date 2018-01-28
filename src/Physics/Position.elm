module Physics.Position exposing (..)

import Physics.Distance exposing (Distance)


type alias Position =
    { x : Float
    , y : Float
    }


add : Position -> Position -> Position
add a b =
    Position (a.x + b.x) (a.y + b.y)


distance : Position -> Position -> Distance
distance a b =
    let
        x =
            a.x - b.x

        y =
            a.y - b.y
    in
        sqrt (x ^ 2 + y ^ 2)


map : (Float -> Float) -> Position -> Position
map fn { x, y } =
    Position (fn x) (fn y)


equals : Position -> Position -> Bool
equals a b =
    a.x == b.x && a.y == b.y
