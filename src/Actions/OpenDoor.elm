module Actions.OpenDoor exposing (openDoor)

import Models.Game exposing (Game)
import Models.Action exposing (Action)
import Models.Cell exposing (isClosedDoor)
import Models.Log exposing (addLine)
import Location.Extra exposing (east, neighbors, pairWithElement)
import Tuple exposing (first, second)
import List exposing (filterMap, filter, isEmpty, map, foldr)
import Matrix exposing (Location, set)


openDoor : Action
openDoor =
  { label = "Open Door"
  , keyChar = 'a'
  , logString = Just "You open the door."
  , isAvailable = isAvailable
  , update = update
  }


isAvailable : Game -> Bool
isAvailable game =
  game.player.location
    |> neighbors
    |> filterMap (pairWithElement game.world)
    |> filter (isClosedDoor << first)
    |> not << isEmpty


update : Game -> Game
update game =
  game.player.location
    |> neighbors
    |> filterMap (pairWithElement game.world)
    |> filter (isClosedDoor << first)
    |> map second
    |> foldr setOpenDoor game


setOpenDoor : Location -> Game -> Game
setOpenDoor location game =
  let
    world = game.world
    newMap = set location Models.Cell.OpenDoor world.map
    newWorld = { world | map = newMap }
    newLog = addLine "You open the door." game.log
  in
    { game | world = newWorld, log = newLog }
