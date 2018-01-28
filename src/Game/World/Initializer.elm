module Game.World.Initializer exposing (..)

import Dict exposing (Dict)
import Game.Object exposing (Object, Material(..), Kind(..))
import Matrix.Point


newline : String
newline =
    """
"""


empty : String
empty =
    ""


objectsFromString : String -> Dict String Object
objectsFromString string =
    string
        |> String.split newline
        |> List.map (String.split "")
        |> List.indexedMap
            (\y symbols ->
                List.indexedMap
                    (\x symbol ->
                        case symbol of
                            "#" ->
                                Just
                                    (Object
                                        (Wall Stone)
                                        (Matrix.Point.toPosition ( x, y ))
                                    )

                            _ ->
                                Nothing
                    )
                    symbols
            )
        |> List.concatMap identity
        |> List.filterMap identity
        |> List.indexedMap (\index object -> ( "object" ++ (toString index), object ))
        |> Dict.fromList


initialObjects : Dict String Object
initialObjects =
    objectsFromString """
##################################################
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
#                                                #
##################################################
"""
