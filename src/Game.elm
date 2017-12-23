module Game exposing (..)

import Creature exposing (Creature)
import World exposing (World)
import Log exposing (Log)


type alias Game =
  { player : Creature
  , world : World
  , log : Log
  }


initial : Game
initial =
  { player = Creature.initial
  , world = World.initial
  , log = Log.initial
  }
