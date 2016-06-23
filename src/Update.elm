module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg (NoOp, TodosMsg))
import Todos.Update


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)
        TodosMsg subMsg ->
            let
                (newTodos, cmd) =
                    Todos.Update.update subMsg model.todos
            in
                ({ model | todos = newTodos }, Cmd.map TodosMsg cmd)
