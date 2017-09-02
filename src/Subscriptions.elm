module Subscriptions exposing (..)

import Models.Game exposing (Game)
import Messages exposing (Msg)
import Keyboard

subscriptions : Game -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.presses Messages.KeyMsg
    ]
