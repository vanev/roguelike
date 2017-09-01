module Models.World exposing (..)


type alias World =
  { height : Int
  , width : Int
  }

  
initial : World
initial =
  { height = 20
  , width = 20
  }
