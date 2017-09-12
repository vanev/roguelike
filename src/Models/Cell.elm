module Models.Cell exposing (..)


type Cell = Wall
          | Floor
          | ClosedDoor
          | OpenDoor
          | Character
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
  (isOpenDoor cell) || (isClosedDoor cell)

isOpenDoor : Cell -> Bool
isOpenDoor cell =
  cell == OpenDoor

isClosedDoor : Cell -> Bool
isClosedDoor cell =
  cell == ClosedDoor

toggleDoor : Cell -> Cell
toggleDoor cell =
  if cell == ClosedDoor then
    OpenDoor
  else
    ClosedDoor
