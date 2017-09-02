module Update exposing (update)

import Models.Game exposing (Game)
import Models.Player exposing (Player)
import Messages exposing (Msg)
import Keyboard exposing (KeyCode)
import Keymap.Key exposing (..)
import Matrix exposing (Matrix, Location)
import Location.Extra exposing (..)


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
  case msg of
    Messages.NoOp ->
      ( game, Cmd.none )

    Messages.KeyMsg keyCode ->
      ( handleKeyMsg keyCode game, Cmd.none )


handleKeyMsg : KeyCode -> Game -> Game
handleKeyMsg keyCode game =
  case Keymap.Key.fromCode keyCode of
    MoveNorth ->
      movePlayer north game
    MoveWest ->
      movePlayer west game
    MoveSouth ->
      movePlayer south game
    MoveEast ->
      movePlayer east game
    Unmapped ->
      game


movePlayer : (Location -> Location) -> Game -> Game
movePlayer locationUpdater game =
  let
    location = locationUpdater game.player.location
    movedPlayer = Models.Player.move game.world location game.player
  in
    { game | player = movedPlayer }
