module Matrix.Point exposing (..)

import Physics.Distance exposing (Distance, foot)
import Physics.Position exposing (Position)


type alias Point =
    ( Int, Int )


size : Distance
size =
    10 * foot


toPosition : Point -> Position
toPosition ( x, y ) =
    Position ((toFloat x) * size) ((toFloat y) * size)


fromPosition : Position -> Point
fromPosition { x, y } =
    ( round (x / size), round (y / size) )
