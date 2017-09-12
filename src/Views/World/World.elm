module Views.World.World exposing (..)

import Views.World.Layer exposing (Layer)
import Models.Game exposing (Game)
import Models.World
import Models.Cell
import Models.Dimensions exposing (Dimensions)
import List exposing (foldr, head, tail, repeat)
import Maybe exposing (withDefault)
import Matrix

type alias World =
  List Layer

dimensions : World -> Dimensions
dimensions world =
  let
    layer = List.head world
    width = Maybe.map Matrix.colCount layer |> Maybe.withDefault 0
    height = Maybe.map Matrix.rowCount layer |> Maybe.withDefault 0
  in
    (width, height)

flatten : World -> Layer
flatten world =
  let
    empty = emptyLayer (dimensions world)
    base = withDefault empty (head world)
    rest = withDefault [empty] (tail world)
  in
    foldr Views.World.Layer.merge base rest

toString : World -> String
toString world =
  flatten world
    |> Views.World.Layer.toString

toWorld : Game -> World
toWorld game =
  [ toCharacterLayer game
  , toMapLayer game
  ]

toMapLayer : Game -> Layer
toMapLayer game =
  game.world.map
    |> Matrix.map Just

toCharacterLayer : Game -> Layer
toCharacterLayer game =
  let
    dimensions = Models.World.dimensions game.world
  in
    emptyLayer dimensions
      |> Matrix.set game.player.location (Just Models.Cell.Character)

emptyLayer : Dimensions -> Layer
emptyLayer (width, height) =
  Matrix.matrix width height (\_ -> Nothing)
