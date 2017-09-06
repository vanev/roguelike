module Update exposing (update)

import Models.Game exposing (Game, movePlayer, performAction)
import Messages exposing (Msg)
import Keyboard exposing (KeyCode)
import Keymap.Key exposing (..)
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
    Action ->
      performAction game
    Unmapped ->
      game
