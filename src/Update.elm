module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg (NoOp, TodosMsg))
import Todos.Update


-- this is our "root" update, which is called many times
-- throughout the lifecycle of the application.
-- update is called whenever there's a new Msg,
-- so that we can decide how it affects the Model,
-- as well as which commands to dispatch.
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    -- since Msg is a union type, we need to handle every single case
    case msg of
        NoOp ->
            (model, Cmd.none)

        -- for anything having to do with Todos, use the todo-specific
        -- update function that we specify in Todos.Update
        TodosMsg subMsg ->
            let
                (newTodos, cmd) =
                    Todos.Update.update subMsg model.todos
            in
                ({ model | todos = newTodos }, Cmd.map TodosMsg cmd)
