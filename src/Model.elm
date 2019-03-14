module Model exposing (Model, initial)

import Game.World as World exposing (World)
import Keyboard exposing (Key)
import Log exposing (Log)


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
