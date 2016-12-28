module Todos.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Todos.Messages exposing (Msg(ShowEditView, ChangeTitle, CreateOrPatch))
import Todos.Models exposing (Todo, TodoEditView(..))


-- this module contains the todo edit view
-- it explains itself for the most part, it is just html


view : TodoEditView -> Html Msg
view ev =
    div []
        -- handle the different cases of the TodoEditView
        [ case ev of
            None ->
                button
                    -- on click, dispatch a message
                    -- TodoEditView holds the value of the text box,
                    -- so we can initialize it with an empty string
                    -- notice how the <| operator is needed here
                    -- to tell elm which arguments belong to what
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
-- so they can be extracted into a separate component (editingInputs)


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
            [ onClick CreateOrPatch ]
            [ text "Save" ]
        ]
