module Main exposing (..)

import Html exposing (program)
import Model exposing (Model, initial)
import Messages exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

main : Program Never Model Msg
main =
  program
    { init = ( initial, Cmd.none )
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
