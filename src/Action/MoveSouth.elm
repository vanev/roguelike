module Action.MoveSouth exposing (moveSouth)

import Game exposing (Game)
import Action exposing (Action)
import Character exposing (..)
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
