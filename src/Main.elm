module Main exposing (main)

import Browser exposing (element)
import Messages exposing (Msg)
import Model exposing (Model, initial)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main =
    element
        { init = \() -> ( initial, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
