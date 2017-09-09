module Views.World.Layer exposing (..)

import Views.World.Symbols exposing (..)
import Views.World.Cell exposing (Cell)
import Matrix exposing (Matrix)
import List
import List.Extra
import String

type alias Layer =
  Matrix Cell

zip : Matrix a -> Matrix a -> Matrix (a, a)
zip first second =
  List.Extra.zip (Matrix.toList first) (Matrix.toList second)
    |> List.map (uncurry List.Extra.zip)
    |> Matrix.fromList

merge : Layer -> Layer -> Layer
merge bottom top =
  zip bottom top
    |> Matrix.map (uncurry Views.World.Cell.merge)

toString : Layer -> String
toString layer =
  Matrix.map Views.World.Cell.toString layer
    |> Matrix.toList
    |> List.map (String.join blank)
    |> String.join lineBreak
