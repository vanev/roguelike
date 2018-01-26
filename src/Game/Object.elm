module Game.Object exposing (..)

import Matrix exposing (Location)


type Material
    = Stone
    | Wood


type Kind
    = Door Material
    | Wall Material


type alias Object =
    { kind : Kind
    , location : Location
    }
