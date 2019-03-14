module Physics.Speed exposing (Speed, time)

import Physics.Distance exposing (Distance)
import Physics.Time exposing (Time)


type alias Speed =
    Float


time : Distance -> Speed -> Time
time =
    (/)
