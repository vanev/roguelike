module Action exposing (..)

import Matrix exposing (Location)


type Action
    = GoTo Location
    | Idle
