module Location.Extra exposing (equals)

import Matrix exposing (Location)


equals : Location -> Location -> Bool
equals ( arow, acol ) ( brow, bcol ) =
    (arow == brow) && (acol == bcol)
