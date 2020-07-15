module Subscriptions exposing (subscriptions)

import Browser.Events exposing (onAnimationFrameDelta)
import Keyboard
import Messages exposing (Msg(..))
import Model exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Sub.map KeyMsg Keyboard.subscriptions
        , onAnimationFrameDelta Tick
        ]
