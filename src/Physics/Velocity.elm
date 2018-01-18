module Physics.Velocity exposing (Velocity, transform)

import Time exposing (Time)
import Physics.Speed exposing (Speed)
import Physics.Direction exposing (Direction)
import Physics.Position exposing (Position)


type alias Velocity =
    { speed : Speed
    , direction : Direction
    }


delta : Time -> Velocity -> Position
delta time { speed, direction } =
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
    delta time velocity
        |> Physics.Position.add source
