module Game.World.Tick exposing (tick)

import Action exposing (Action(..))
import Dict exposing (Dict)
import Game.Creature exposing (Creature)
import Game.World exposing (World)
import List.Extra
import Matrix.Point exposing (Point)
import Maybe.Extra
import Physics.Position exposing (Position)
import Physics.Time exposing (Time)


type alias ValuedPoint =
    { point : Point
    , value : Float
    }


type alias Queue =
    List ValuedPoint


addToQueue : ValuedPoint -> Queue -> Queue
addToQueue vp queue =
    List.Extra.find (\{ point, value } -> vp.point == point && vp.value >= value) queue
        |> Maybe.Extra.isJust
        |> (\shouldNotAdd ->
                if shouldNotAdd then
                    queue

                else
                    queue ++ [ vp ]
           )


adjacentPoints : Point -> List Point
adjacentPoints ( x, y ) =
    [ ( x + 1, y )
    , ( x - 1, y )
    , ( x, y + 1 )
    , ( x, y - 1 )
    ]


valuePoint : World -> Creature -> Float -> Point -> ValuedPoint
valuePoint _ _ baseValue point =
    ValuedPoint point baseValue


adjacent : World -> Creature -> ValuedPoint -> List ValuedPoint
adjacent world creature { point, value } =
    adjacentPoints point
        |> List.map (valuePoint world creature (value + 1))


buildQueue : World -> Creature -> List ValuedPoint -> List ValuedPoint
buildQueue world creature queue =
    let
        newQueue =
            List.concatMap (adjacent world creature) queue
                |> List.foldl addToQueue queue

        origin =
            Matrix.Point.fromPosition creature.position

        includesOrigin =
            List.Extra.find (\{ point } -> point == origin) newQueue
                |> Maybe.Extra.isJust
    in
    if includesOrigin || (List.length newQueue > 1000) then
        newQueue

    else
        buildQueue world creature newQueue


initialValuedPoint : Point -> ValuedPoint
initialValuedPoint point =
    ValuedPoint point 0


queueToPoint : World -> Creature -> Position -> Queue
queueToPoint world creature target =
    Matrix.Point.fromPosition target
        |> initialValuedPoint
        |> List.singleton
        |> buildQueue world creature


getAdjacentFromQueue : Point -> Queue -> List ValuedPoint
getAdjacentFromQueue source queue =
    let
        aps =
            adjacentPoints source
    in
    List.filter (\{ point } -> List.member point aps) queue


nextStep : World -> Creature -> Position -> Maybe Position
nextStep world creature target =
    queueToPoint world creature target
        |> getAdjacentFromQueue (Matrix.Point.fromPosition creature.position)
        |> List.sortBy .value
        |> List.reverse
        |> List.head
        |> Maybe.map .point
        |> Maybe.map Matrix.Point.toPosition


handleGoTo : Position -> Time -> World -> String -> Creature -> Creature
handleGoTo target _ world _ creature =
    let
        maybeNext =
            nextStep world creature target

        shouldStopMoving =
            case maybeNext of
                Just next ->
                    Physics.Position.distance target next
                        |> (>) Matrix.Point.size

                Nothing ->
                    True

        action =
            if shouldStopMoving then
                Idle

            else
                creature.action

        cooldown =
            Game.Creature.cooldown creature
    in
    { creature
        | position = Maybe.withDefault creature.position maybeNext
        , action = action
        , cooldown = cooldown
    }


isEnemy : Creature -> String -> Creature -> Bool
isEnemy target _ creature =
    target /= creature


distance : Creature -> Creature -> Float
distance a b =
    Physics.Position.distance a.position b.position


closer : Creature -> Creature -> Creature -> Creature
closer target a b =
    if distance target a < distance target b then
        a

    else
        b


isVisible : Creature -> String -> Creature -> Bool
isVisible target _ other =
    Physics.Position.distance target.position other.position < 20 * Matrix.Point.size


visibleEnemies : World -> Creature -> Dict String Creature
visibleEnemies world creature =
    world.creatures
        |> Dict.filter (isEnemy creature)
        |> Dict.filter (isVisible creature)


nearestEnemy : World -> Creature -> Maybe Creature
nearestEnemy world creature =
    let
        enemies =
            creature
                |> visibleEnemies world
                |> Dict.values
    in
    List.foldr
        (\current maybeClosest -> Maybe.map (closer creature current) maybeClosest)
        (List.head enemies)
        enemies


skip : (comparable -> a -> Bool) -> (comparable -> a -> a) -> comparable -> a -> a
skip predicate fn comparable a =
    if predicate comparable a then
        a

    else
        fn comparable a


isPlayer : String -> Creature -> Bool
isPlayer key _ =
    key == "player"


skipPlayer : (String -> Creature -> Creature) -> String -> Creature -> Creature
skipPlayer =
    skip isPlayer


setAction : Time -> World -> String -> Creature -> Creature
setAction _ world _ creature =
    case creature.action of
        Idle ->
            let
                action =
                    creature
                        |> nearestEnemy world
                        |> Maybe.map (.position >> GoTo)
                        |> Maybe.withDefault Idle
            in
            { creature | action = action }

        _ ->
            creature


performAction : Time -> World -> String -> Creature -> Creature
performAction delta world key creature =
    if creature.cooldown >= 0 then
        { creature | cooldown = creature.cooldown - delta }

    else
        case creature.action of
            GoTo target ->
                handleGoTo target delta world key creature

            Idle ->
                creature


tick : Time -> World -> World
tick delta world =
    let
        creatures =
            world.creatures
                |> Dict.map (skipPlayer (setAction delta world))
                |> Dict.map (performAction delta world)
    in
    { world
        | creatures = creatures
    }
