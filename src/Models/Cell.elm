module Models.Cell exposing (..)

type Cell = Wall
          | Floor
          | Player
          | Empty

fromString : String -> Cell
fromString string =
  case string of
    "#" -> Wall
    "." -> Floor
    _ -> Empty
