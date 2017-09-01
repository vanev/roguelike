module Main exposing (..)

import Html exposing (program)
import Model exposing (..)
import Messages exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

-- Init

init : ( Model, Cmd Msg )
init =
  ( initial
  , Cmd.none
  )

-- Main

main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
