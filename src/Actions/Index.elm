module Actions.Index exposing (..)

import Models.Action exposing (Action)
import Models.Game exposing (Game)
import Actions.MoveNorth exposing (..)
import Actions.MoveSouth exposing (..)
import Actions.MoveEast exposing (..)
import Actions.MoveWest exposing (..)
import Actions.OpenDoor exposing (..)
import Actions.CloseDoor exposing (..)
import List exposing (filter)
import List.Extra exposing (find)

actions : List Action
actions =
  [ moveNorth
  , moveSouth
  , moveEast
  , moveWest
  , openDoor
  , closeDoor
  ]

availableActions : Game -> List Action
availableActions game =
  filter (\action -> action.isAvailable game) actions

findByKey : Char -> Game -> Maybe Action
findByKey keyChar game =
  availableActions game
    |> find (\action -> action.keyChar == keyChar)
