module Location.Extra exposing (..)

import Models.World exposing (World)
import Models.Cell exposing (Cell)
import Matrix exposing (Location, get)


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


pairWithElement : World -> Location -> Maybe (Cell, Location)
pairWithElement world location =
  case get location world.map of
    Just cell ->
      Just (cell, location)

    Nothing ->
      Nothing
