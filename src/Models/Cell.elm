module Models.Cell exposing (..)

type Cell = Wall
          | Floor
          | ClosedDoor
          | OpenDoor
          | Player
          | Empty

fromString : String -> Cell
fromString string =
  case string of
    "#" -> Wall
    "." -> Floor
    "D" -> ClosedDoor
    "d" -> OpenDoor
    _ -> Empty
