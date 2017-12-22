module Action exposing (..)

import Game exposing (Game)
import String exposing (fromChar)


type alias Action =
  { label : String
  , keyChar : Char
  , logString : Maybe String
  , isAvailable : Game -> Bool
  , update : Game -> Game
  }

toSidebarString : Action -> String
toSidebarString action =
  (fromChar action.keyChar) ++ "    " ++ action.label
