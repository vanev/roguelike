module Character exposing (..)

import World exposing (World)
import Cell
import Matrix exposing (Location)


type alias Character =
  { location : Location
  }


initial : Character
initial =
  { location = (1,1)
  }


move : World -> Location -> Character -> Character
move world location player =
  let
    cell = Matrix.get location world.map
  in
    case cell of
      Just c ->
        case c of
          Cell.Floor ->
            { player | location = location }
          Cell.OpenDoor ->
            { player | location = location }
          _ ->
            player
      Nothing ->
        player
