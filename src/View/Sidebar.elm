module View.Sidebar exposing (content)

import List
import Dict
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Model exposing (Model)
import Game.Creature exposing (Creature, hitPoints)
import View.Panel exposing (Content(Leaf))


renderHealthBar : Creature -> Html Msg
renderHealthBar creature =
    let
        name =
            creature |> .race |> toString

        hp =
            creature |> hitPoints |> toString
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
