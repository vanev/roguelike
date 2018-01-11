module Messages exposing (..)

import Keyboard.Extra as Keyboard
import Time exposing (Time)
import Matrix exposing (Location)
import Game.World exposing (Tile)


type Msg
    = NoOp
    | KeyMsg Keyboard.Msg
    | TileClick Location Tile
    | Tick Time
