module Keymap.Key exposing (..)

import Keyboard exposing (KeyCode)
import Char

type Key = MoveNorth
         | MoveSouth
         | MoveEast
         | MoveWest
         | Action
         | Unmapped

fromCode : KeyCode -> Key
fromCode code =
  Char.fromCode code
    |> fromChar

fromChar : Char -> Key
fromChar char =
  case char of
    'w' -> MoveNorth
    's' -> MoveSouth
    'd' -> MoveEast
    'a' -> MoveWest
    'f' -> Action
    _ -> Unmapped
