module Game.Object exposing (Kind(..), Material(..), Object)

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
    }
