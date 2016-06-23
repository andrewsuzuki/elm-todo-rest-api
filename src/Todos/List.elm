module Todos.List exposing (..)

import Html exposing (..)
import Todos.Messages exposing (Msg)
import Todos.Models exposing (Todo)

view : List Todo -> Html Msg
view todos =
    table []
        [ thead []
            [ th [] [ text "Id" ]
            , th [] [ text "Title" ]
            , th [] [ text "Completed?" ]
            ]
        , tbody [] <| List.map todo <| todos
        ]

todo : Todo -> Html Msg
todo { id, title, completed } =
    tr []
        [ td [] [ text (toString id) ]
        , td [] [ text title ]
        , td [] [ text (if completed then "yes" else "no") ]
        ]
