module Views.World.Layer exposing (..)

import Views.World.Symbols exposing (..)
import Views.World.Cell exposing (Cell)
import Matrix exposing (Matrix)
import List
import String
import Maybe

type alias Layer =
  Matrix Cell

zip : Matrix a -> Matrix a -> Matrix (a, a)
zip first second =
  let
    zipper location firstCell =
      let
        secondCell = Matrix.get location second
          |> Maybe.withDefault firstCell
      in
        (firstCell, secondCell)
  in
    Matrix.mapWithLocation zipper first

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
