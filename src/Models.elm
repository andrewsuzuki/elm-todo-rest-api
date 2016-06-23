module Models exposing (..)

import Messages exposing (Msg (TodosMsg))
import Todos.Models exposing (Todo, dummyTodo)
import Todos.Commands


type alias Model =
    { todos : List Todo }

init : (Model, Cmd Msg)
init =
    (Model [], Cmd.map TodosMsg Todos.Commands.fetchAll)
