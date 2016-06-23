module Todos.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)

import Todos.Messages exposing (Msg (ShowEditView, ChangeTitle, CreateOrPatch))
import Todos.Models exposing (Todo, TodoEditView (..))


view : TodoEditView -> Html Msg
view ev =
    div []
        [ case ev of
            None ->
                button
                    [ onClick <| ShowEditView <| New "" ]
                    [ text "Create New Todo" ]
            New title ->
                div []
                    [ h2 [] [ text "New Todo" ]
                    , editingInputs title
                    ]
            Editing { title } ->
                div []
                    [ h2 [] [ text <| "Editing Todo: " ++ title ]
                    , editingInputs title
                    ]
        ]


-- the "new" and "editing" forms are identical,
-- so they can be extracted into a separate widget (editingInputs)
editingInputs : String -> Html Msg
editingInputs title =
    div []
        [ button
            [ onClick <| ShowEditView None ]
            [ text "Back" ]
        , input
            [ value title
            , placeholder "Title"
            , onInput ChangeTitle
            ]
            []
        , button
            [ onClick <| CreateOrPatch ]
            [ text "Save" ]
        ]
