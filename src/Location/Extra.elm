module Location.Extra exposing (fromPosition, toPosition, equals)

import Matrix exposing (Location)
import Physics.Position exposing (Position)
import Physics.Distance exposing (inFeet, foot)


posCoordToLocCoord : Float -> Int
posCoordToLocCoord =
    inFeet >> (/) 5 >> floor


fromPosition : Position -> Location
fromPosition { x, y } =
    ( posCoordToLocCoord y, posCoordToLocCoord x )


locCoordToPosCoord : Int -> Float
locCoordToPosCoord =
    toFloat >> (*) 10 >> (*) foot


toPosition : Location -> Position
toPosition ( row, col ) =
    Position (locCoordToPosCoord col) (locCoordToPosCoord row)


equals : Location -> Location -> Bool
equals ( arow, acol ) ( brow, bcol ) =
    (arow == brow) && (acol == bcol)
