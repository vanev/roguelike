module Update exposing (update)

import Messages exposing (..)
import Models.Game exposing (Game)


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
  case msg of
    NoOp ->
      ( game, Cmd.none )
