module Game.Creature exposing (..)

import Dict exposing (Dict)
import Time exposing (hour)
import Physics.Position exposing (Position)
import Physics.Distance exposing (mile, foot)
import Physics.Speed exposing (Speed)
import Action exposing (Action(..))
import Game.Item exposing (Item)


type Race
    = Human
    | Goblin


type alias Inventory =
    { head : Maybe Item
    , neck : Maybe Item
    , chest : Maybe Item
    , leftWrist : Maybe Item
    , rightWrist : Maybe Item
    , leftHand : Maybe Item
    , rightHand : Maybe Item
    , leftFinger : Maybe Item
    , rightFinger : Maybe Item
    , legs : Maybe Item
    , leftFoot : Maybe Item
    , rightFoot : Maybe Item
    , bag : Dict String Item
    }


type alias Creature =
    { position : Position
    , race : Race
    , items : Inventory
    , damage : Float
    , action : Action
    , cooldown : Float
    }


cooldown : Creature -> Float
cooldown creature =
    case creature.action of
        GoTo _ ->
            creature
                |> speed
                |> Physics.Speed.time (5 * foot)

        Idle ->
            0


speed : Creature -> Speed
speed creature =
    case creature.race of
        Human ->
            (15 * mile) / hour

        Goblin ->
            (10 * mile) / hour


hitPoints : Creature -> Float
hitPoints creature =
    let
        baseHitPoints =
            case creature.race of
                Human ->
                    15

                Goblin ->
                    10
    in
        baseHitPoints - creature.damage
