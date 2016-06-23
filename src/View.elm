module View exposing (..)

import Html exposing (..)
import Html.App

import Models exposing (Model)
import Messages exposing (Msg (TodosMsg))
import Todos.List


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Todos" ]
        , Html.App.map TodosMsg <| Todos.List.view model.todos
        ]
