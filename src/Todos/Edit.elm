module Todos.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)

import Todos.Messages exposing (Msg (ShowEditView, ChangeTitle, CreateOrPatch))
import Todos.Models exposing (Todo, TodoEditView (..))


view : TodoEditView -> Html Msg
view ev =
    div []
        <| case ev of
            None ->
                [ button
                    [ onClick <| ShowEditView <| New "" ]
                    [ text "Create New Todo" ]
                ]
            New title ->
                [ h2 [] [ text "New Todo" ]
                , editingInputs title
                ]
            Editing { title } ->
                [ h2 [] [ text <| "Editing Todo: " ++ title ]
                , editingInputs title
                ]


editingInputs : String -> Html Msg
editingInputs title =
    div []
        [ button
            [ onClick <| ShowEditView None ]
            [ text "Back" ]
        , input
            [ value title
            , onInput ChangeTitle
            ]
            []
        , button
            [ onClick <| CreateOrPatch ]
            [ text "Save" ]
        ]
