module Update exposing (update)

import Game exposing (Game)
import Action exposing (Action)
import Messages exposing (Msg)
import Keyboard exposing (KeyCode)
import Time exposing (Time)
import Char exposing (fromCode)
import Action.Index exposing (findByKey)


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
  case msg of
    Messages.NoOp ->
      ( game, Cmd.none )

    Messages.KeyMsg keyCode ->
      ( handleKeyMsg keyCode game, Cmd.none )

    Messages.Tick delta ->
      ( handleTick (delta / 1000) game, Cmd.none )


handleKeyMsg : KeyCode -> Game -> Game
handleKeyMsg keyCode game =
  findByKey (fromCode keyCode) game
    |> performAction game


performAction : Game -> Maybe Action -> Game
performAction game maybeAction =
  case maybeAction of
    Just action ->
      action.update game

    Nothing ->
      game

handleTick : Time -> Game -> Game
handleTick delta game =
  game
