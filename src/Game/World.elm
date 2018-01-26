module Game.World exposing (..)

import Dict exposing (Dict)
import Time exposing (Time)
import Matrix exposing (Matrix, Location)
import Location.Extra
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
    { location = ( 5, 5 )
    , race = Game.Creature.Human
    , items = emptyItems
    , damage = 0
    , action = Idle
    , cooldown = 0
    }


goblin : Creature
goblin =
    { location = ( 5, 10 )
    , race = Game.Creature.Goblin
    , items = emptyItems
    , damage = 0
    , action = Idle
    , cooldown = 0
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
        |> List.filter (.location >> Location.Extra.equals location)
        |> List.head


itemAtLocation : Location -> World -> Maybe Item
itemAtLocation location world =
    Dict.values world.items
        |> List.filter (.location >> Location.Extra.equals location)
        |> List.head


objectAtLocation : Location -> World -> Maybe Object
objectAtLocation location world =
    Dict.values world.objects
        |> List.filter (.location >> Location.Extra.equals location)
        |> List.head


handleGoTo : Location -> Time -> World -> String -> Creature -> Creature
handleGoTo target delta world key creature =
    let
        row =
            if (Matrix.row target) > (Matrix.row creature.location) then
                (Matrix.row creature.location) + 1
            else if (Matrix.row target) < (Matrix.row creature.location) then
                (Matrix.row creature.location) - 1
            else
                (Matrix.row creature.location)

        col =
            if (Matrix.col target) > (Matrix.col creature.location) then
                (Matrix.col creature.location) + 1
            else if (Matrix.col target) < (Matrix.col creature.location) then
                (Matrix.col creature.location) - 1
            else
                (Matrix.col creature.location)

        location =
            ( row, col )

        arrived =
            Location.Extra.equals location target

        action =
            if arrived then
                Idle
            else
                creature.action

        cooldown =
            1 * Time.second
    in
        { creature
            | location = location
            , action = action
            , cooldown = cooldown
        }


updateCreature : Time -> World -> String -> Creature -> Creature
updateCreature delta world key creature =
    if creature.cooldown >= 0 then
        { creature | cooldown = creature.cooldown - delta }
    else
        case creature.action of
            GoTo target ->
                handleGoTo target delta world key creature

            Idle ->
                creature


tick : Time -> World -> World
tick delta world =
    { world | creatures = Dict.map (updateCreature delta world) world.creatures }
