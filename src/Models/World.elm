module Models.World exposing (..)

import Models.Dimensions exposing (Dimensions)
import Matrix exposing (Matrix)

type alias World =
  { map : Matrix String
  }

initial : World
initial =
  { map =
      Matrix.fromList
        [ [ "#", "#", "#", "#", "#" ]
        , [ "#", "0", "0", "0", "#" ]
        , [ "#", "0", "0", "0", "#" ]
        , [ "#", "0", "0", "0", "#" ]
        , [ "#", "#", "#", "#", "#" ]
        ]
  }

dimensions : World -> Dimensions
dimensions world =
  let
    width = Matrix.colCount world.map
    height = Matrix.rowCount world.map
  in
    (width, height)
