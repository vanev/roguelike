module Models.Player exposing (..)

import Models.World exposing (World)
import Models.Cell
import Matrix exposing (Location)


type alias Player =
  { location : Location
  }


initial : Player
initial =
  { location = (1,1)
  }


move : World -> Location -> Player -> Player
move world location player =
  let
    cell = Matrix.get location world.map
  in
    case cell of
      Just c ->
        case c of
          Models.Cell.Floor ->
            { player | location = location }
          _ ->
            player
      Nothing ->
        player
