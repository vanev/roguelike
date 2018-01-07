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
position time { speed, direction } =
    let
        distance =
            speed * time

        y =
            (sin direction) * distance

        x =
            (cos direction) * distance
    in
        Position x y


transform : Position -> Time -> Velocity -> Position
transform source time velocity =
    position time velocity
        |> Physics.Position.add source
