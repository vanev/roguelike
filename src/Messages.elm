module Messages exposing (..)

import Keyboard.Extra as Keyboard
import Time exposing (Time)


type Msg
    = NoOp
    | KeyMsg Keyboard.Msg
    | Tick Time
