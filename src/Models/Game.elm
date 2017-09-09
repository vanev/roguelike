module Models.Game exposing (..)

import Models.Player exposing (..)
import Models.World exposing (..)
import Models.Log exposing (..)
import Models.Cell exposing (..)
import Matrix exposing (Location)
import Location.Extra exposing (..)


type alias Game =
  { player : Player
  , world : World
  , log : Log
  }


initial : Game
initial =
  { player = Models.Player.initial
  , world = Models.World.initial
  , log = Models.Log.initial
  }


movePlayer : (Location -> Location) -> Game -> Game
movePlayer locationUpdater game =
  let
    location = locationUpdater game.player.location
    movedPlayer = Models.Player.move game.world location game.player
  in
    { game | player = movedPlayer }


performAction : Game -> Game
performAction game =
  game.player.location
    |> neighbors
    |> List.filterMap (pairWithElement game.world)
    |> List.filter (\(cell, _) -> isDoor cell)
    |> List.foldr toggleDoor game


toggleDoor : (Cell, Location) -> Game -> Game
toggleDoor (cell, location) game =
  let
    world = game.world
    newCell = Models.Cell.toggleDoor cell
    newMap = Matrix.set location newCell world.map
    newWorld = { world | map = newMap }
    logLine = if isOpenDoor cell then "Door closed." else "Door opened."
    newLog = Models.Log.addLine logLine game.log
  in
    { game | world = newWorld, log = newLog }
