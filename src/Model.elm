module Model exposing (..)

import Game.World as World exposing (World)
import Log exposing (Log)
import Keyboard.Extra exposing (Key)


type alias Model =
    { world : World
    , log : Log
    , pressedKeys : List Key
    }


initial : Model
initial =
    { world = World.initial
    , log = Log.initial
    , pressedKeys = []
    }
