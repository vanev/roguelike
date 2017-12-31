module Game.Creature exposing (..)

import Dict exposing (Dict)
import Matrix exposing (Location)
import Location.Extra
import Time exposing (hour)
import Physics.Position exposing (Position)
import Physics.Distance exposing (mile)
import Physics.Speed exposing (Speed)
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
  }

speed : Creature -> Speed
speed creature =
  case creature.race of
    Human -> (10 * mile) / hour
    Goblin -> (10 * mile) / hour

location : Creature -> Location
location = .position >> Location.Extra.fromPosition
