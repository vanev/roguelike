module Subscriptions exposing (..)

import Models.Game exposing (Game)
import Messages exposing (Msg)

subscriptions : Game -> Sub Msg
subscriptions model =
  Sub.none
