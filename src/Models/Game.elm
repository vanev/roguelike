module Models.Game exposing (..)

import Models.Character exposing (Character)
import Models.World exposing (World)
import Models.Log exposing (Log)


type alias Game =
  { player : Character
  , world : World
  , log : Log
  }


initial : Game
initial =
  { player = Models.Character.initial
  , world = Models.World.initial
  , log = Models.Log.initial
  }
