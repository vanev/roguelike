module Action exposing (..)

import Physics.Position exposing (Position)


type Action
    = GoTo Position
    | Idle
