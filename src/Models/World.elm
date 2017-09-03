module Models.World exposing (..)

import Models.Cell exposing (..)
import Models.Dimensions exposing (Dimensions)
import Views.World.Symbols exposing (..)
import Matrix exposing (Matrix)
import String
import List

type alias World =
  { map : Matrix Cell
  }

mapString : String
mapString = """####################################################
#..........#.......................................#
#..........#.......................................#
#..........#.......................................#
#..........#.......................................#
#..........D.......................................#
#..........#.......................................#
############.......................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
#..................................................#
####################################################"""

initial : World
initial =
  fromString mapString

fromString : String -> World
fromString string =
  let
    map = String.split lineBreak string
            |> List.map (String.split blank)
            |> Matrix.fromList
            |> Matrix.map Models.Cell.fromString
  in
    { map = map }

dimensions : World -> Dimensions
dimensions world =
  let
    width = Matrix.colCount world.map
    height = Matrix.rowCount world.map
  in
    (height, width)
