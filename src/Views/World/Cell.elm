module Views.World.Cell exposing (..)

import Models.Cell
import Maybe exposing (withDefault)

type alias Cell =
  Maybe Models.Cell.Cell

merge : Cell -> Cell -> Cell
merge bottom top =
  case top of
    Just _ ->
      top
    Nothing ->
      bottom

toCell : Cell -> Models.Cell.Cell
toCell cell =
  case cell of
    Just c -> c
    Nothing -> Models.Cell.Empty

toString : Cell -> String
toString cell =
  case (toCell cell) of
    Models.Cell.Wall -> "#"
    Models.Cell.Floor -> "."
    Models.Cell.Player -> "@"
    Models.Cell.ClosedDoor -> "D"
    Models.Cell.OpenDoor -> "d"
    Models.Cell.Empty -> " "
