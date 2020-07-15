module Game.Item exposing (Item, Kind(..), Slot(..))

import Physics.Position exposing (Position)


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
    { position : Position
    , kind : Kind
    , name : String
    }
