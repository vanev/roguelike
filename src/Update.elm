module Update exposing (update)

import Game exposing (Game)
import Model exposing (Model)
import Action exposing (Action)
import Messages exposing (Msg)
import Keyboard exposing (KeyCode)
import Time exposing (Time)
import Char exposing (fromCode)
import Action.Index exposing (findByKey)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Messages.NoOp ->
      ( model, Cmd.none )

    Messages.KeyMsg keyCode ->
      ( handleKeyMsg keyCode model, Cmd.none )

    Messages.Tick delta ->
      ( handleTick (delta / 1000) game, Cmd.none )


handleKeyMsg : KeyCode -> Model -> Model
handleKeyMsg keyCode model =
  findByKey (fromCode keyCode) model.game
    |> performAction model.game
    |> \game -> { model | game = game }


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
