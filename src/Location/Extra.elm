module Location.Extra exposing (equals, distance, within)

import Matrix exposing (Location)


distance : Location -> Location -> Float
distance ( arow, acol ) ( brow, bcol ) =
    let
        rowDelta =
            (arow - brow)

        colDelta =
            (acol - bcol)
    in
        abs (sqrt (toFloat (rowDelta ^ 2 + colDelta ^ 2)))


within : Int -> Location -> Location -> Bool
within delta a b =
    (toFloat delta) > (distance a b)


equals : Location -> Location -> Bool
equals ( arow, acol ) ( brow, bcol ) =
    (arow == brow) && (acol == bcol)
