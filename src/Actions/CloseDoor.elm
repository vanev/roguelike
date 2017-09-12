module Actions.CloseDoor exposing (closeDoor)

import Models.Game exposing (Game)
import Models.Action exposing (Action)
import Models.Cell exposing (isOpenDoor)
import Models.Log exposing (addLine)
import Location.Extra exposing (east, neighbors, pairWithElement)
import Tuple exposing (first, second)
import List exposing (filterMap, filter, isEmpty, map, foldr)
import Matrix exposing (Location, set)


closeDoor : Action
closeDoor =
  { label = "Close Door"
  , keyChar = 'a'
  , logString = Just "You close the door."
  , isAvailable = isAvailable
  , update = update
  }


isAvailable : Game -> Bool
isAvailable game =
  game.player.location
    |> neighbors
    |> filterMap (pairWithElement game.world)
    |> filter (isOpenDoor << first)
    |> not << isEmpty


update : Game -> Game
update game =
  game.player.location
    |> neighbors
    |> filterMap (pairWithElement game.world)
    |> filter (isOpenDoor << first)
    |> map second
    |> foldr setClosedDoor game


setClosedDoor : Location -> Game -> Game
setClosedDoor location game =
  let
    world = game.world
    newMap = set location Models.Cell.ClosedDoor world.map
    newWorld = { world | map = newMap }
    newLog = addLine "You close the door." game.log
  in
    { game | world = newWorld, log = newLog }
