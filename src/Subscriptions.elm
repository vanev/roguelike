module Subscriptions exposing (..)

import Model exposing (Model)
import Messages exposing (Msg)
import Keyboard
import AnimationFrame

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.presses Messages.KeyMsg
    , AnimationFrame.diffs Messages.Tick
    ]
