module Models.Player exposing (..)


type alias Player =
  { x : Int
  , y : Int
  }

  
initial : Player
initial =
  { x = 0
  , y = 0
  }
