module Game exposing (..)

import Character exposing (Character)
import World exposing (World)
import Log exposing (Log)


type alias Game =
  { player : Character
  , world : World
  , log : Log
  }


initial : Game
initial =
  { player = Character.initial
  , world = World.initial
  , log = Log.initial
  }
