module Game.World exposing (..)

import Dict exposing (Dict)
import Matrix exposing (Matrix)
import Matrix.Point
import Action exposing (Action(..))
import Game.Creature exposing (Creature, Inventory)
import Game.Item exposing (Item)
import Game.Object exposing (Object)
import Game.World.Initializer as Initializer


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
    { position = Matrix.Point.toPosition ( 5, 5 )
    , race = Game.Creature.Human
    , items = emptyItems
    , damage = 0
    , action = Idle
    , cooldown = 0
    }


goblin : Creature
goblin =
    { position = Matrix.Point.toPosition ( 30, 5 )
    , race = Game.Creature.Goblin
    , items = emptyItems
    , damage = 0
    , action = Idle
    , cooldown = 0
    }


initial : World
initial =
    { heightmap = Matrix.repeat 50 50 Dirt
    , creatures =
        Dict.fromList
            [ ( "player", player )
            , ( "goblin", goblin )
            ]
    , items = Dict.fromList []
    , objects = Initializer.initialObjects
    }
