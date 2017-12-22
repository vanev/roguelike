module Subscriptions exposing (..)

import Game exposing (Game)
import Messages exposing (Msg)
import Keyboard
import AnimationFrame

subscriptions : Game -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.presses Messages.KeyMsg
    , AnimationFrame.diffs Messages.Tick
    ]
