module Physics.Time exposing (Time, day, hour, millisecond, minute, second)


type alias Time =
    Float


millisecond : Time
millisecond =
    1.0


second : Time
second =
    1000 * millisecond


minute : Time
minute =
    60 * second


hour : Time
hour =
    60 * minute


day : Time
day =
    24 * hour
