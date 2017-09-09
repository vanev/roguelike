module Models.Log exposing (..)

type alias Log =
  { lines : List String
  , current : Int
  }

initial : Log
initial =
  { lines = []
  , current = 0
  }

addLine : String -> Log -> Log
addLine line log =
  let
    newLines = log.lines ++ [line]
    newCurrent = (List.length newLines) - 1
  in
    { log
    | lines = newLines
    , current = newCurrent
    }
