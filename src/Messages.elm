module Messages exposing (Msg(..))

import Game.World exposing (Tile)
import Keyboard
import Matrix.Point exposing (Point)
import Physics.Time exposing (Time)


type Msg
    = NoOp
    | KeyMsg Keyboard.Msg
    | TileClick Point Tile
    | Tick Time
