module Actions.MoveWest exposing (moveWest)

import Models.Game exposing (Game)
import Models.Action exposing (Action)
import Models.Player exposing (..)
import Location.Extra exposing (..)
import Matrix exposing (..)

moveWest : Action
moveWest =
  { label = "Move West"
  , keyChar = 'j'
  , logString = Nothing
  , isAvailable = isAvailable
  , update = update
  }

isAvailable : Game -> Bool
isAvailable game =
  let
    loc = west game.player.location
    cell = get loc game.world.map
  in
    case cell of
      Just cell -> True
      Nothing   -> False

update : Game -> Game
update game =
  let
    loc = west game.player.location
    player = move game.world loc game.player
  in
    { game | player = player }
