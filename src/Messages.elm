module Messages exposing (..)

import Keyboard

type Msg
  = NoOp
  | KeyMsg Keyboard.KeyCode
