module Location.Extra exposing (..)

import Matrix exposing (Location)

north : Location -> Location
north (row, col) =
  (row - 1, col)

south : Location -> Location
south (row, col) =
  (row + 1, col)

east : Location -> Location
east (row, col) =
  (row, col + 1)

west : Location -> Location
west (row, col) =
  (row, col - 1)

neighbors : Location -> List Location
neighbors location =
  [ north location
  , east location
  , south location
  , west location
  ]
