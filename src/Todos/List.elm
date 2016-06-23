module Todos.List exposing (..)

import Html exposing (..)
import Todos.Messages exposing (Msg)
import Todos.Models exposing (Todo)


-- the main view here is a table with headers and body rows for each todo
view : List Todo -> Html Msg
view todos =
    table []
        [ thead []
            [ th [] [ text "Id" ]
            , th [] [ text "Title" ]
            , th [] [ text "Completed?" ]
            ]
        -- below, we keep things modular by mapping a todo row view to every todo
        , tbody [] <| List.map todo <| todos
        -- note:
        -- instead, the above could have been:
        --     tbody [] (List.map todo todos)
        -- but, it does demonstrate a good use of the
        -- right-to-left function application operator
        ]

-- a single todo row
todo : Todo -> Html Msg
todo { id, title, completed } =
    tr []
        [ td [] [ text (toString id) ]
        , td [] [ text title ]
        , td [] [ text (if completed then "yes" else "no") ]
        ]
