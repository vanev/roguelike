module Update exposing (update)

import Models.Game exposing (Game)
import Models.World exposing (World)
import Models.Cell exposing (..)
import Models.Player exposing (Player)
import Messages exposing (Msg)
import Keyboard exposing (KeyCode)
import Keymap.Key exposing (..)
import Matrix exposing (Matrix, Location)
import Location.Extra exposing (..)
import List


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
  case msg of
    Messages.NoOp ->
      ( game, Cmd.none )

    Messages.KeyMsg keyCode ->
      ( handleKeyMsg keyCode game, Cmd.none )


handleKeyMsg : KeyCode -> Game -> Game
handleKeyMsg keyCode game =
  case Keymap.Key.fromCode keyCode of
    MoveNorth ->
      movePlayer north game
    MoveWest ->
      movePlayer west game
    MoveSouth ->
      movePlayer south game
    MoveEast ->
      movePlayer east game
    Action ->
      performAction game
    Unmapped ->
      game


movePlayer : (Location -> Location) -> Game -> Game
movePlayer locationUpdater game =
  let
    location = locationUpdater game.player.location
    movedPlayer = Models.Player.move game.world location game.player
  in
    { game | player = movedPlayer }

performAction : Game -> Game
performAction game =
  -- Get the player's location.
  -- Get neighboring locations.
  -- Get neighboring cells.
  -- Get location of cell with door.
  -- Set location of cell with door to opposite.
  game.player.location
    |> neighbors
    |> List.map (pairWithCell game.world)
    |> List.filterMap moveMaybeToTopLevel
    |> List.filter (\(cell, _) -> isDoor cell)
    |> List.foldr toggleDoor game
  -- Probably figure out what action can be taken.
    -- If there is a door next to the player, toggle it (open <-> closed).
  -- Execute the action.

pairWithCell : World -> Location -> (Maybe Cell, Location)
pairWithCell world location =
  (Matrix.get location world.map, location)

moveMaybeToTopLevel : (Maybe Cell, Location) -> Maybe (Cell, Location)
moveMaybeToTopLevel (maybeCell, location) =
  case maybeCell of
    Just cell -> Just (cell, location)
    Nothing -> Nothing

isDoor : Cell -> Bool
isDoor cell =
  cell == Models.Cell.OpenDoor || cell == Models.Cell.ClosedDoor

toggleDoor : (Cell, Location) -> Game -> Game
toggleDoor (cell, location) game =
  let
    newCell =
      if cell == Models.Cell.ClosedDoor then
        Models.Cell.OpenDoor
      else
        Models.Cell.ClosedDoor
    newMap = Matrix.set location newCell game.world.map
    world = game.world
    newWorld = { world | map = newMap }
  in
    { game | world = newWorld }
