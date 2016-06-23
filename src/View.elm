module View exposing (..)

import Html exposing (..)
import Html.App

import Models exposing (Model)
import Messages exposing (Msg (TodosMsg))
import Todos.Edit
import Todos.List


-- this is our "root" view. the entire appearance of our application
-- is derived here from the app state (model)
view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Todos" ]
        -- render the todos edit and list sub-views using pars of the model,
        -- then "tag" outgoing messages with TodosMsg
        , Html.App.map TodosMsg <| Todos.Edit.view model.todoEditView
        , br [] []
        , Html.App.map TodosMsg <| Todos.List.view model.todos
        ]
