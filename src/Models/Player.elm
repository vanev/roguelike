module Models.Player exposing (..)

import Matrix exposing (Location)


type alias Player =
  { location : Location
  }


initial : Player
initial =
  { location = (1,1)
  }
