module Action.Index exposing (..)

import Action exposing (Action)
import Game exposing (Game)
import Action.MoveNorth exposing (..)
import Action.MoveSouth exposing (..)
import Action.MoveEast exposing (..)
import Action.MoveWest exposing (..)
import Action.OpenDoor exposing (..)
import Action.CloseDoor exposing (..)
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
