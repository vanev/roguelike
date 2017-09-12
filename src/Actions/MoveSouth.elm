module Actions.MoveSouth exposing (moveSouth)

import Models.Game exposing (Game)
import Models.Action exposing (Action)
import Models.Player exposing (..)
import Location.Extra exposing (..)
import Matrix exposing (..)

moveSouth : Action
moveSouth =
  { label = "Move South"
  , keyChar = 'k'
  , logString = Nothing
  , isAvailable = isAvailable
  , update = update
  }

isAvailable : Game -> Bool
isAvailable game =
  let
    loc = south game.player.location
    cell = get loc game.world.map
  in
    case cell of
      Just cell -> True
      Nothing   -> False

update : Game -> Game
update game =
  let
    loc = south game.player.location
    player = move game.world loc game.player
  in
    { game | player = player }
