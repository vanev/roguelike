module Models.Game exposing (..)

import Models.Player exposing (Player)
import Models.World exposing (World)
import Models.Log exposing (Log)


type alias Game =
  { player : Player
  , world : World
  , log : Log
  }


initial : Game
initial =
  { player = Models.Player.initial
  , world = Models.World.initial
  , log = Models.Log.initial
  }
