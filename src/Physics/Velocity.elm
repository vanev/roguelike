module Physics.Velocity exposing (..)

import Time exposing (Time)
import Physics.Speed exposing (Speed)
import Physics.Direction exposing (Direction)
import Physics.Position exposing (Position)

type alias Velocity =
  { speed : Speed
  , direction : Direction
  }

position : Time -> Velocity -> Position
position time velocity =
  let
    speed = velocity.speed
    direction = velocity.direction
    distance = speed * time
  in
    case direction of
      0 -> Position 0 -distance
      90 -> Position distance 0
      180 -> Position 0 distance
      270 -> Position -distance 0
      _ -> Position 0 0

transform : Position -> Time -> Velocity -> Position
transform source time velocity =
  position time velocity
    |> Physics.Position.add source
