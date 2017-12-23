module Model exposing (..)

import Game exposing (Game)

type alias Model =
  { game : Game
  }

initial : Model
initial =
  { game = Game.initial
  }
