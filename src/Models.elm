module Models exposing (..)

import Messages exposing (Msg)
import Todos.Models exposing (Todo, dummyTodo)


type alias Model =
    { todos : List Todo }

init : (Model, Cmd Msg)
init =
    (Model [ dummyTodo ], Cmd.none)
