module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(NoOp, TodosMsg))
import Todos.Update


-- this is our "root" update, which is called many times
-- throughout the lifecycle of the application,
-- any time it receives a new Msg.
-- when we receive a new Msg,
-- we can decide how it affects the Model (app state),
-- as well as which commands we might want to dispatch.
-- notice that we must return a tuple of the new model and the command together!
-- this is because elm, like pretty much all languages, can only return one value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    -- since Msg is a union type, we need to handle
    -- every single case in a case..of statement
    case msg of
        -- "no operation", so return the model exactly how we received it
        -- Cmd.none means "i don't want to run any commands this time"
        NoOp ->
            ( model, Cmd.none )

        -- for anything having to do with Todos, use the todo-specific
        -- update function that we specify in Todos.Update
        -- for more info on why this needs to be done, see the root Messages.elm
        --
        -- since TodosMsg has a "payload" (a Todos.Messages.Msg),
        -- we let a different update function very similar to this one
        -- handle any updates relevant to Todos. here we can unpack
        -- that subMsg right in the case.
        TodosMsg subMsg ->
            -- a let..in statement lets us do some "setup" by creating new vars
            -- which are limited in scope to the body in the "in" part of the statement
            let
                -- this is called "destructuring". since Todos.Update.update
                -- always returns a tuple with three elements, we can give names
                -- to those three elements easily
                ( newTodoEditView, newTodos, cmd ) =
                    -- here we call Todos.Update.update with the subMsg
                    -- and any parts of the root model it might want to update
                    Todos.Update.update subMsg model.todoEditView model.todos

                -- since the model is an immutable record, we can create
                -- a new record while changing the values of it that
                -- Todos.Update.update might have changed
                -- the vertical bar ("|") can be read as "such that"
                newModel =
                    { model | todoEditView = newTodoEditView, todos = newTodos }
            in
                -- return our updated model as well as any commands
                -- the sub-update gave us. We need to tag those commands first
                -- with the TodosMsg (see Messages.elm for explanation)
                ( newModel, Cmd.map TodosMsg cmd )
