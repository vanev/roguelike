module Subscriptions exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(..))
import Keyboard.Extra as Keyboard
import AnimationFrame

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map KeyMsg Keyboard.subscriptions
    , AnimationFrame.diffs Tick
    ]
