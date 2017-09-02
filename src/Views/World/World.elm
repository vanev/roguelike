module Views.World.World exposing (..)

import Views.World.Layer exposing (Layer)
import Models.Game exposing (Game)
import List exposing (foldr, head, tail, repeat)
import Maybe exposing (withDefault)
import Matrix

type alias World =
  List Layer

flatten : World -> Layer
flatten world =
  let
    base = withDefault emptyLayer (head world)
    rest = withDefault [emptyLayer] (tail world)
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
  Matrix.fromList [ [ Just "#", Just "#", Just "#", Just "#", Just "#" ]
  , [ Just "#", Just "0", Just "0", Just "0", Just "#" ]
  , [ Just "#", Just "0", Just "0", Just "0", Just "#" ]
  , [ Just "#", Just "0", Just "0", Just "0", Just "#" ]
  , [ Just "#", Just "#", Just "#", Just "#", Just "#" ]
  ]

toCharacterLayer : Game -> Layer
toCharacterLayer game =
  let
    location = Matrix.loc game.player.y game.player.x
  in
    emptyLayer
      |> Matrix.set location (Just "@")

emptyLayer : Layer
emptyLayer =
  Matrix.matrix 10 10 (\_ -> Nothing)
