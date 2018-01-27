module Game.World.Tick exposing (tick)

import Dict exposing (Dict)
import Time exposing (Time)
import Game.World exposing (World)
import Game.Creature exposing (Creature)
import Action exposing (Action(..))
import Matrix exposing (Location)
import Location.Extra


handleGoTo : Location -> Time -> World -> String -> Creature -> Creature
handleGoTo target delta world key creature =
    let
        targetRow =
            Matrix.row target

        targetCol =
            Matrix.col target

        creatureRow =
            Matrix.row creature.location

        creatureCol =
            Matrix.col creature.location

        row =
            if targetRow > creatureRow then
                creatureRow + 1
            else if targetRow < creatureRow then
                creatureRow - 1
            else
                creatureRow

        col =
            if targetCol > creatureCol then
                creatureCol + 1
            else if targetCol < creatureCol then
                creatureCol - 1
            else
                creatureCol

        location =
            ( row, col )

        arrived =
            Location.Extra.equals location target

        action =
            if arrived then
                Idle
            else
                creature.action

        cooldown =
            Game.Creature.cooldown creature
    in
        { creature
            | location = location
            , action = action
            , cooldown = cooldown
        }


isEnemy : Creature -> String -> Creature -> Bool
isEnemy target key creature =
    target /= creature


distance : Creature -> Creature -> Float
distance a b =
    Location.Extra.distance a.location b.location


closer : Creature -> Creature -> Creature -> Creature
closer target a b =
    if distance target a < distance target b then
        a
    else
        b


isVisible : Creature -> String -> Creature -> Bool
isVisible target key other =
    Location.Extra.within 20 target.location other.location


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
isPlayer key creature =
    key == "player"


skipPlayer : (String -> Creature -> Creature) -> String -> Creature -> Creature
skipPlayer =
    skip isPlayer


setAction : Time -> World -> String -> Creature -> Creature
setAction delta world key creature =
    case creature.action of
        Idle ->
            let
                action =
                    creature
                        |> nearestEnemy world
                        |> Maybe.map (.location >> GoTo)
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