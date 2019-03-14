module View.Sidebar exposing (content)

import Dict
import Game.Creature exposing (Creature, Race(..), hitPoints)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import List
import Messages exposing (Msg)
import Model exposing (Model)
import View.Panel exposing (Content(..))


raceToString : Race -> String
raceToString race =
    case race of
        Human ->
            "Human"

        Goblin ->
            "Goblin"


renderHealthBar : Creature -> Html Msg
renderHealthBar creature =
    let
        name =
            creature |> .race |> raceToString

        hp =
            creature |> hitPoints |> String.fromFloat
    in
    div
        [ class "HealthBar"
        ]
        [ text name
        , text hp
        ]


render : Model -> Html Msg
render model =
    let
        healthBarsSection =
            div
                [ class "--section"
                ]
                (List.map renderHealthBar (Dict.values model.world.creatures))
    in
    div [ class "Sidebar" ] [ healthBarsSection ]


content : Model -> Content
content =
    render >> Leaf
