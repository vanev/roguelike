module Action.MoveEast exposing (moveEast)

import Game exposing (Game)
import Action exposing (Action)
import Creature exposing (..)
import Location.Extra exposing (..)
import Matrix exposing (..)

moveEast : Action
moveEast =
  { label = "Move East"
  , keyChar = 'l'
  , logString = Nothing
  , isAvailable = isAvailable
  , update = update
  }

isAvailable : Game -> Bool
isAvailable game =
  let
    loc = east game.player.location
    cell = get loc game.world.map
  in
    case cell of
      Just cell -> True
      Nothing   -> False

update : Game -> Game
update game =
  let
    loc = east game.player.location
    player = move game.world loc game.player
  in
    { game | player = player }
