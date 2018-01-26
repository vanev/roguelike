module Update exposing (update)

import Dict
import Time exposing (Time)
import Keyboard.Extra as Keyboard
import Messages exposing (Msg(..))
import Model exposing (Model)
import Action exposing (Action)
import Matrix exposing (Location)
import Game.World as World exposing (Tile)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        KeyMsg keyMsg ->
            ( handleKeyMsg keyMsg model, Cmd.none )

        TileClick location tile ->
            ( handleTileClick location tile model, Cmd.none )

        Tick delta ->
            ( handleTick delta model, Cmd.none )


handleKeyMsg : Keyboard.Msg -> Model -> Model
handleKeyMsg keyMsg model =
    { model
        | pressedKeys = Keyboard.update keyMsg model.pressedKeys
    }


handleTileClick : Location -> Tile -> Model -> Model
handleTileClick location tile model =
    let
        world =
            model.world

        updater =
            (\creature -> { creature | action = Action.GoTo location })

        newWorld =
            { world
                | creatures = Dict.update "player" (Maybe.map updater) world.creatures
            }
    in
        { model | world = newWorld }


handleTick : Time -> Model -> Model
handleTick delta model =
    { model
        | world = World.tick delta model.world
    }
