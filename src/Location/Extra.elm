module Location.Extra exposing (..)

import Matrix exposing (Location)
import Physics.Position exposing (Position)
import Physics.Distance exposing (inFeet)


convert : Float -> Int
convert coord =
    coord
        |> inFeet
        |> \c ->
            c
                / 5
                |> floor


fromPosition : Position -> Location
fromPosition { x, y } =
    ( convert y, convert x )


equals : Location -> Location -> Bool
equals ( arow, acol ) ( brow, bcol ) =
    (arow == brow) && (acol == bcol)


north : Location -> Location
north ( row, col ) =
    ( row - 1, col )


south : Location -> Location
south ( row, col ) =
    ( row + 1, col )


east : Location -> Location
east ( row, col ) =
    ( row, col + 1 )


west : Location -> Location
west ( row, col ) =
    ( row, col - 1 )


neighbors : Location -> List Location
neighbors location =
    [ north location
    , east location
    , south location
    , west location
    ]
