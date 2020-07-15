module Action exposing (Action(..))

import Physics.Position exposing (Position)


type Action
    = GoTo Position
    | Idle
