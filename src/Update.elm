module Update exposing (update)

import Models.Game exposing (Game)
import Models.World exposing (World)
import Models.Player exposing (Player)
import Models.Cell
import Messages exposing (Msg)
import Keyboard
import Char
import Matrix exposing (Matrix, Location)

update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
  case msg of
    Messages.NoOp ->
      ( game, Cmd.none )

    Messages.KeyMsg keyCode ->
      ( handleKeyMsg keyCode game, Cmd.none )


handleKeyMsg : Keyboard.KeyCode -> Game -> Game
handleKeyMsg keyCode game =
  case Char.fromCode keyCode of
    'w' ->
      let
        movedPlayer = north game.player.location
                        |> movePlayer game.world game.player
      in
        { game | player = movedPlayer }

    'a' ->
      let
        movedPlayer = west game.player.location
                        |> movePlayer game.world game.player
      in
        { game | player = movedPlayer }

    's' ->
      let
        movedPlayer = south game.player.location
                        |> movePlayer game.world game.player
      in
        { game | player = movedPlayer }

    'd' ->
      let
        movedPlayer = east game.player.location
                        |> movePlayer game.world game.player
      in
        { game | player = movedPlayer }

    _ ->
      game

north : Location -> Location
north (row, col) =
  (row - 1, col)

south : Location -> Location
south (row, col) =
  (row + 1, col)

east : Location -> Location
east (row, col) =
  (row, col + 1)

west : Location -> Location
west (row, col) =
  (row, col - 1)

movePlayer : World -> Player -> Location -> Player
movePlayer world player location =
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
