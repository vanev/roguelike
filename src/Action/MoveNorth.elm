module Action.MoveNorth exposing (moveNorth)

import Game exposing (Game)
import Action exposing (Action)
import Creature exposing (..)
import Location.Extra exposing (..)
import Matrix exposing (..)

moveNorth : Action
moveNorth =
  { label = "Move North"
  , keyChar = 'i'
  , logString = Nothing
  , isAvailable = isAvailable
  , update = update
  }

isAvailable : Game -> Bool
isAvailable game =
  let
    loc = north game.player.location
    cell = get loc game.world.map
  in
    case cell of
      Just cell -> True
      Nothing   -> False

update : Game -> Game
update game =
  let
    loc = north game.player.location
    player = move game.world loc game.player
  in
    { game | player = player }
