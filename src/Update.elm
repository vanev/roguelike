module Update exposing (update)

import Time exposing (Time)
import Keyboard.Extra as Keyboard
import Messages exposing (Msg(..))
import Model exposing (Model)
import Action exposing (Action)
import Game.World as World


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        KeyMsg keyMsg ->
            ( handleKeyMsg keyMsg model, Cmd.none )

        Tick delta ->
            ( handleTick delta model, Cmd.none )


handleKeyMsg : Keyboard.Msg -> Model -> Model
handleKeyMsg keyMsg model =
    { model
        | pressedKeys = Keyboard.update keyMsg model.pressedKeys
    }


handleTick : Time -> Model -> Model
handleTick delta model =
    let
        actions =
            List.map Action.fromKey model.pressedKeys
    in
        { model
            | world = World.tick delta actions model.world
        }
