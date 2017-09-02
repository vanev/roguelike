module Views.World.Cell exposing (..)

import Views.World.Symbols exposing (..)
import Maybe exposing (withDefault)
import String exposing (join)

type alias Cell =
  Maybe String

merge : Cell -> Cell -> Cell
merge bottom top =
  case top of
    Just _ ->
      top
    Nothing ->
      bottom

toString : Cell -> String
toString = withDefault blank
