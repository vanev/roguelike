module Views.World.Cell exposing (..)

import Cell
import Maybe exposing (withDefault)

type alias Cell =
  Maybe Cell.Cell

merge : Cell -> Cell -> Cell
merge bottom top =
  case top of
    Just _ ->
      top
    Nothing ->
      bottom

toCell : Cell -> Cell.Cell
toCell cell =
  case cell of
    Just c -> c
    Nothing -> Cell.Empty

toString : Cell -> String
toString cell =
  case (toCell cell) of
    Cell.Wall -> "#"
    Cell.Floor -> "."
    Cell.Character -> "@"
    Cell.ClosedDoor -> "D"
    Cell.OpenDoor -> "d"
    Cell.Empty -> " "
