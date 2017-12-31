module Action exposing (..)

import Keyboard.Extra exposing (Key(..))
import Physics.Direction exposing (Direction)

type Action
  = Move Direction
  | Idle

fromKey : Key -> Action
fromKey key =
  case key of
    ArrowUp -> Move 0
    ArrowRight -> Move 90
    ArrowDown -> Move 180
    ArrowLeft -> Move 270
    _ -> Idle
