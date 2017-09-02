module Views.World.Row exposing (..)

import Views.World.Cell exposing (Cell)
import Views.World.Symbols exposing (..)
import List exposing (map)
import List.Extra exposing (zip)
import String exposing (join)

type alias Row =
  List Cell

merge : Row -> Row -> Row
merge bottom top =
  zip bottom top
    |> map (uncurry Views.World.Cell.merge)

toString : Row -> String
toString row =
  map Views.World.Cell.toString row
    |> join blank
