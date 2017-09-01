module Main exposing (..)

import Html exposing (program)
import Models.Game exposing (..)
import Messages exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

-- Init

init : ( Game, Cmd Msg )
init =
  ( Models.Game.initial
  , Cmd.none
  )

-- Main

main : Program Never Game Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
