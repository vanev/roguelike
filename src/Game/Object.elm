module Game.Object exposing (..)

import Matrix exposing (Location)
import Location.Extra
import Physics.Position exposing (Position)

type Material
  = Stone
  | Wood

type Kind
  = Door Material
  | Wall Material

type alias Object =
  { kind : Kind
  , position : Position
  -- , size : Size
  }

location : Object -> Location
location = .position >> Location.Extra.fromPosition
