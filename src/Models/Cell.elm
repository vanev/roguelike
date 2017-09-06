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


isDoor : Cell -> Bool
isDoor cell =
  cell == OpenDoor || cell == ClosedDoor

toggleDoor : Cell -> Cell
toggleDoor cell =
  if cell == ClosedDoor then
    OpenDoor
  else
    ClosedDoor
