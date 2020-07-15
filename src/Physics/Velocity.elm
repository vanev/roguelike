module Physics.Velocity exposing (Velocity, transform)

import Physics.Direction exposing (Direction)
import Physics.Position exposing (Position)
import Physics.Speed exposing (Speed)
import Time exposing (Posix, posixToMillis)


type alias Velocity =
    { speed : Speed
    , direction : Direction
    }


delta : Posix -> Velocity -> Position
delta time { speed, direction } =
    let
        distance =
            speed * toFloat (posixToMillis time)

        y =
            sin direction * distance

        x =
            cos direction * distance
    in
    Position x y


transform : Position -> Posix -> Velocity -> Position
transform source time velocity =
    delta time velocity
        |> Physics.Position.add source
