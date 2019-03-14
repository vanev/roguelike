module Update exposing (update)

import Action exposing (Action)
import Dict
import Game.World as World exposing (Tile)
import Game.World.Tick
import Keyboard
import Matrix.Point exposing (Point)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Physics.Time exposing (Time)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        KeyMsg keyMsg ->
            ( handleKeyMsg keyMsg model, Cmd.none )

        TileClick point tile ->
            ( handleTileClick point tile model, Cmd.none )

        Tick delta ->
            ( handleTick delta model, Cmd.none )


handleKeyMsg : Keyboard.Msg -> Model -> Model
handleKeyMsg keyMsg model =
    { model
        | pressedKeys = Keyboard.update keyMsg model.pressedKeys
    }


handleTileClick : Point -> Tile -> Model -> Model
handleTileClick point tile model =
    let
        world =
            model.world

        position =
            Matrix.Point.toPosition point

        updater =
            \creature -> { creature | action = Action.GoTo position }

        newWorld =
            { world
                | creatures =
                    Dict.update "player" (Maybe.map updater) world.creatures
            }
    in
    { model | world = newWorld }


handleTick : Time -> Model -> Model
handleTick delta model =
    { model
        | world = Game.World.Tick.tick delta model.world
    }
