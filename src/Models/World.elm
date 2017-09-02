module Models.World exposing (..)

import Models.Cell exposing (..)
import Models.Dimensions exposing (Dimensions)
import Matrix exposing (Matrix)

type alias World =
  { map : Matrix Cell
  }

initial : World
initial =
  { map =
      Matrix.fromList
        [ [ Wall, Wall, Wall, Wall, Wall ]
        , [ Wall, Floor, Floor, Floor, Wall ]
        , [ Wall, Floor, Floor, Floor, Wall ]
        , [ Wall, Floor, Floor, Floor, Wall ]
        , [ Wall, Wall, Wall, Wall, Wall ]
        ]
  }

dimensions : World -> Dimensions
dimensions world =
  let
    width = Matrix.colCount world.map
    height = Matrix.rowCount world.map
  in
    (width, height)
