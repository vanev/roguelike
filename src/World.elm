module World exposing (..)

import Cell exposing (..)
import Dimensions exposing (Dimensions)
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
  String.split lineBreak string
    |> List.map (String.split blank)
    |> Matrix.fromList
    |> Matrix.map Cell.fromString
    |> World

dimensions : World -> Dimensions
dimensions world =
  let
    width = Matrix.colCount world.map
    height = Matrix.rowCount world.map
  in
    (height, width)
