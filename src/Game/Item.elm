module Game.Item exposing (..)

import Matrix exposing (Location)


type Slot
    = Head
    | Neck
    | Chest
    | Wrist
    | Hand
    | Finger
    | Legs
    | Foot


type Kind
    = Equipable Slot
    | Held
    | Unequipable


type alias Item =
    { location : Location
    , kind : Kind
    , name : String
    }
