module Game.World exposing (..)

import Dict exposing (Dict)
import Time exposing (Time)
import Matrix exposing (Matrix, Location)
import Location.Extra
import Physics.Position exposing (Position)
import Physics.Distance exposing (foot)
import Physics.Velocity exposing (Velocity)
import Action exposing (Action(..))
import Game.Creature exposing (Creature, Inventory)
import Game.Item exposing (Item)
import Game.Object exposing (Object)

type Tile
  = Dirt
  | Grass

type alias World =
  { heightmap : Matrix Tile
  , creatures : Dict String Creature
  , items : Dict String Item
  , objects : Dict String Object
  }

emptyItems : Inventory
emptyItems =
  { head = Nothing
  , neck = Nothing
  , chest = Nothing
  , leftWrist = Nothing
  , rightWrist = Nothing
  , leftHand = Nothing
  , rightHand = Nothing
  , leftFinger = Nothing
  , rightFinger = Nothing
  , legs = Nothing
  , leftFoot = Nothing
  , rightFoot = Nothing
  , bag = Dict.fromList []
  }

player : Creature
player =
  { position = Position (5 * foot) (5 * foot)
  , race = Game.Creature.Human
  , items = emptyItems
  }

initial : World
initial =
  { heightmap = Matrix.square 50 (always Dirt)
  , creatures = Dict.fromList
    [ ("player", player)
    ]
  , items = Dict.fromList []
  , objects = Dict.fromList []
  }

creatureAtLocation : Location -> World -> Maybe Creature
creatureAtLocation location world =
  Dict.values world.creatures
    |> List.filter ((Location.Extra.equals location) << Game.Creature.location)
    |> List.head

itemAtLocation : Location -> World -> Maybe Item
itemAtLocation location world =
  Dict.values world.items
    |> List.filter ((Location.Extra.equals location) << Game.Item.location)
    |> List.head

objectAtLocation : Location -> World -> Maybe Object
objectAtLocation location world =
  Dict.values world.objects
    |> List.filter ((Location.Extra.equals location) << Game.Object.location)
    |> List.head

applyPlayerAction : Time -> Action -> World -> World
applyPlayerAction time action world =
  let
    maybePlayer = Dict.get "player" world.creatures
  in
    case maybePlayer of
      Just player ->
        case action of
          Move direction ->
            let
              velocity = Velocity (Game.Creature.speed player) direction
              newPlayer =
                { player
                | position = Physics.Velocity.transform player.position time velocity
                }
            in
              { world
              | creatures = Dict.insert "player" newPlayer world.creatures
              }

          Idle ->
            world

      Nothing ->
        world

tick : Time -> List Action -> World -> World
tick time actions world =
  List.foldr (applyPlayerAction time) world actions
