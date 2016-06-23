module Models exposing (..)

import Messages exposing (Msg (TodosMsg))
import Todos.Models exposing (Todo, TodoEditView (None))
import Todos.Commands


-- this is our "root" model
-- all app state is stored in this record
type alias Model =
    { todos : List Todo
    , todoEditView : TodoEditView }


-- this is the initial state for the application
-- this is supplied to Html.App.Program in Main
init : (Model, Cmd Msg)
init =
    let
        -- type aliases can be used as functions
        -- here we're creating the initial model with an empty list of Todos
        model = Model [] None

        -- on initial load, we can "batch" any number of commands
        cmds = Cmd.batch
            -- create a single command to fetch todos from api,
            -- mapping it with the "root" Messages.Msg.TodosMsg
            [ Cmd.map TodosMsg Todos.Commands.fetchAll
            ]
    in
        (model, cmds)
