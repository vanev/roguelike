module Messages exposing (..)

import Keyboard.Extra as Keyboard
import Time exposing (Time)
import Matrix.Point exposing (Point)
import Game.World exposing (Tile)


type Msg
    = NoOp
    | KeyMsg Keyboard.Msg
    | TileClick Point Tile
    | Tick Time
