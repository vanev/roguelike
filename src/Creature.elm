module Creature exposing (..)

import World exposing (World)
import Cell
import Matrix exposing (Location)


type alias Creature =
  { location : Location
  }


initial : Creature
initial =
  { location = (1,1)
  }


move : World -> Location -> Creature -> Creature
move world location creature =
  let
    cell = Matrix.get location world.map
  in
    case cell of
      Just c ->
        case c of
          Cell.Floor ->
            { creature | location = location }
          Cell.OpenDoor ->
            { creature | location = location }
          _ ->
            creature
      Nothing ->
        creature
