module View.Cell exposing (..)

import Matrix exposing (Location)
import Game.World exposing (Tile(..))
import Game.Creature exposing (Creature)
import Game.Item exposing (Item)
import Game.Object exposing (Object)

type alias Cell =
  { tile : Tile
  , creature : Maybe Creature
  , item : Maybe Item
  , object : Maybe Object
  }

toCell : Game.World.World -> Location -> Tile -> Cell
toCell gameWorld location tile =
  { tile = tile
  , creature = Game.World.creatureAtLocation location gameWorld
  , item = Game.World.itemAtLocation location gameWorld
  , object = Game.World.objectAtLocation location gameWorld
  }

toString : Cell -> String
toString { tile, creature, item, object } =
  -- case ( tile, creature, item, object ) of
  case ( creature, object, item, tile ) of
    (Just creature, _, _, _) ->
      case creature.race of
        Game.Creature.Human -> "@"
        Game.Creature.Goblin -> "G"

    (Nothing, Just object, _, _) -> "O"

    (Nothing, Nothing, Just item, _) -> "I"

    (Nothing, Nothing, Nothing, tile) ->
      case tile of
        Dirt -> "∙"
        Grass -> "◦"
