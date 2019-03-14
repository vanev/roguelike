module Matrix exposing
    ( Matrix
    , empty
    , fromList
    , get
    , getRow
    , height
    , indexedMap
    , repeat
    , toIndexedArray
    , width
    )

import Array exposing (Array)
import List


type alias Matrix a =
    { size : ( Int, Int )
    , data : Array a
    }


empty : Matrix a
empty =
    { size = ( 0, 0 )
    , data = Array.empty
    }


width : Matrix a -> Int
width =
    .size >> Tuple.first


height : Matrix a -> Int
height =
    .size >> Tuple.second


repeat : Int -> Int -> a -> Matrix a
repeat x y v =
    { size = ( x, y )
    , data = Array.repeat (x * y) v
    }


fromList : List (List a) -> Maybe (Matrix a)
fromList list =
    let
        h =
            List.length list

        w =
            List.length <|
                case List.head list of
                    Just x ->
                        x

                    Nothing ->
                        []

        allSame =
            List.isEmpty <| List.filter (\x -> List.length x /= w) list
    in
    if not allSame then
        Nothing

    else
        Just { size = ( w, h ), data = Array.fromList <| List.concat list }


get : Int -> Int -> Matrix a -> Maybe a
get i j matrix =
    let
        pos =
            (j * width matrix) + i
    in
    if (i < width matrix && i > -1) && (j < height matrix && j > -1) then
        Array.get pos matrix.data

    else
        Nothing


getRow : Int -> Matrix a -> Maybe (Array a)
getRow j matrix =
    let
        start =
            j * width matrix

        end =
            start + width matrix
    in
    if end > (width matrix * height matrix) then
        Nothing

    else
        Just <| Array.slice start end matrix.data


getColumn : Int -> Matrix a -> Maybe (Array a)
getColumn i matrix =
    let
        w =
            Tuple.first matrix.size

        h =
            Tuple.second matrix.size

        indices =
            List.map (\x -> x * w + i) (List.range 0 (h - 1))
    in
    if i >= w then
        Nothing

    else
        Just <|
            Array.fromList <|
                List.foldl
                    (\index ls ->
                        case Array.get index matrix.data of
                            Just v ->
                                ls ++ [ v ]

                            Nothing ->
                                ls
                    )
                    []
                    indices


indexedMap : (Int -> Int -> a -> b) -> Matrix a -> Matrix b
indexedMap f matrix =
    let
        f_ i v =
            let
                x =
                    remainderBy (width matrix) i

                y =
                    i // width matrix
            in
            f x y v

        data =
            Array.fromList <| List.indexedMap f_ <| Array.toList matrix.data
    in
    { size = matrix.size
    , data = data
    }


toIndexedArray : Matrix a -> Array ( ( Int, Int ), a )
toIndexedArray matrix =
    (indexedMap (\x y v -> ( ( x, y ), v )) matrix).data
