module Game.World exposing (..)

import Dict exposing (Dict)
import Time exposing (Time)
import Matrix exposing (Matrix, Location)
import Location.Extra
import Physics.Position exposing (Position)
import Physics.Distance exposing (foot, inFeet)
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
    , damage = 0
    , action = Idle
    }


goblin : Creature
goblin =
    { position = Position (50 * foot) (5 * foot)
    , race = Game.Creature.Goblin
    , items = emptyItems
    , damage = 0
    , action = Idle
    }


initial : World
initial =
    { heightmap = Matrix.square 50 (always Dirt)
    , creatures =
        Dict.fromList
            [ ( "player", player )
            , ( "goblin", goblin )
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


updateCreature : Time -> World -> String -> Creature -> Creature
updateCreature time world string creature =
    case creature.action of
        GoTo { x, y } ->
            let
                direction =
                    atan2 (y - creature.position.y) (x - creature.position.x)

                velocity =
                    Velocity (Game.Creature.speed creature) direction

                position =
                    Physics.Velocity.transform creature.position time velocity

                roundPosition =
                    inFeet >> floor >> toFloat

                roundedPosition =
                    Physics.Position.map roundPosition position

                roundedTarget =
                    Physics.Position.map roundPosition (Position x y)

                arrived =
                    Physics.Position.equals roundedPosition roundedTarget
            in
                { creature
                    | position = position
                    , action =
                        if arrived then
                            Idle
                        else
                            creature.action
                }

        Idle ->
            creature


tick : Time -> World -> World
tick time world =
    { world | creatures = Dict.map (updateCreature time world) world.creatures }
