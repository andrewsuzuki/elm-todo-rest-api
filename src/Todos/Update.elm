module Todos.Update exposing (..)

import Todos.Messages exposing (Msg (..))
import Todos.Models exposing (TodoEditView (..), Todo)
import Todos.Commands
import Utils


-- handle messages relevant to model.todos
update : Msg -> TodoEditView -> List Todo -> (TodoEditView, List Todo, Cmd Msg)
update msg ev todos =
    case msg of
        NoOp ->
            ( ev, todos, Cmd.none )

        -- show a new edit view
        -- used by the "Edit", Create New Todo", and "Back" buttons
        ShowEditView nev ->
            ( nev, todos, Cmd.none )

        -- if we're editing a new todo, then this updates the nested
        -- type variable representing the title
        -- if we're editing an existing todo, then this updated the
        -- title property inside the nested type variable representing the todo
        ChangeTitle title ->
            let nev =
                case ev of
                    None ->
                        ev
                    New _ ->
                        New title
                    Editing todo ->
                        Editing { todo | title = title }
            in ( nev, todos, Cmd.none )

        -- this is matched when there is an http error
        Fail _ ->
            -- disregard error; do nothing
            ( ev, todos, Cmd.none )

        -- fetch all success
        FetchAllDone newTodos ->
            ( ev, newTodos, Cmd.none )

        -- create success
        CreateDone newTodo ->
            ( ev, Utils.mergeById todos newTodo, Cmd.none )

        -- patch success
        PatchDone newTodo ->
            ( ev, Utils.mergeById todos newTodo, Cmd.none )

        -- delete success
        DeleteDone todo ->
            ( ev, Utils.removeById todos todo, Cmd.none )

        -- this is whenever the "save" button is clicked
        CreateOrPatch ->
            let cmd =
                case ev of
                    -- not reachable currently, but
                    -- we have to handle this case
                    None ->
                        Cmd.none
                    -- create a new todo
                    New title ->
                        Todos.Commands.create title
                    -- patch an existing todo
                    Editing todo ->
                        Todos.Commands.patch todo
            -- exit edit view and give our command
            -- see note above in Complete
            in ( None, todos, cmd )

        -- this is matched when "Done is clicked"
        Complete todo ->
            let
                -- make the new todo
                newTodo = { todo | completed = True }

                -- if we want optimistic updates, we can make the changes ourselves
                -- AND dispatch the patch command.
                -- newTodos = Utils.mergeById todos newTodo

                -- instead, we'll let PatchDone do the updating for us
                newTodos = todos
            in
                ( ev, newTodos, Todos.Commands.patch newTodo )

        -- this is matched when "Revert" is clicked
        Revert todo ->
            let
                -- make the new todo
                newTodo = { todo | completed = False }

                -- see note above in Complete
            in
                ( ev, todos, Todos.Commands.patch newTodo )

        -- this is a generic Patch for a todo that has already been altered
        Patch todo ->
            -- see note above in Complete
            ( ev, todos, Todos.Commands.patch todo )

        -- this is matched when "Delete" is clicked
        Delete todo ->
            -- see note above in Complete
            ( ev, todos, Todos.Commands.delete todo )

        -- this is matched when "Clear Completed" is clicked
        -- in the real world, this would probably be a separate endpoint
        -- but we'll just create separate delete commands for the
        -- todos that are completed
        DeleteCompleted ->
            let cmds =
                todos
                    -- filter completed todos
                    -- similar to clojure, we can use a "dot notation"
                    -- to make a property-accessing function (.completed)
                    |> List.filter .completed
                    -- attach a delete command to each
                    |> List.map Todos.Commands.delete
            in ( ev, todos, Cmd.batch cmds )
