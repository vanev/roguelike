module Models.Character exposing (..)

import Models.World exposing (World)
import Models.Cell
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
          Models.Cell.Floor ->
            { player | location = location }
          Models.Cell.OpenDoor ->
            { player | location = location }
          _ ->
            player
      Nothing ->
        player
