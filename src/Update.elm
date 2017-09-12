module Update exposing (update)

import Models.Game exposing (Game)
import Models.Action exposing (Action)
import Messages exposing (Msg)
import Keyboard exposing (KeyCode)
import Char exposing (fromCode)
import Actions.Index exposing (findByKey)


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
  case msg of
    Messages.NoOp ->
      ( game, Cmd.none )

    Messages.KeyMsg keyCode ->
      ( handleKeyMsg keyCode game, Cmd.none )


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
