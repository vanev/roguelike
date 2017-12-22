module Messages exposing (..)

import Keyboard
import Time exposing (Time)

type Msg
  = NoOp
  | KeyMsg Keyboard.KeyCode
  | Tick Time
