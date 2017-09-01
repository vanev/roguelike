module Models.Game exposing (..)

import Models.Player exposing (..)
import Models.World exposing (..)


type alias Game =
  { player : Player
  , world : World
  }


initial : Game
initial =
  { player = Models.Player.initial
  , world = Models.World.initial
  }
