module Todos.Update exposing (..)

-- we want Msg along with all of its subtypes automatically (..)

import Todos.Messages exposing (Msg(..))
import Todos.Models exposing (TodoEditView(..), Todo)
import Todos.Commands
import Utils


-- handle messages relevant to model.todos


update : Msg -> TodoEditView -> List Todo -> ( TodoEditView, List Todo, Cmd Msg )
update msg ev todos =
    case msg of
        -- "no operation"
        NoOp ->
            ( ev, todos, Cmd.none )

        -- show a new edit view
        -- used by the "Edit", Create New Todo", and "Back" buttons
        ShowEditView nev ->
            ( nev, todos, Cmd.none )

        -- if we're editing a new todo, then this updates the nested
        -- type variable representing the title
        -- if we're editing an existing todo, then this updated the
        -- title "payload" inside the nested type variable representing the todo
        ChangeTitle title ->
            let
                nev =
                    case ev of
                        None ->
                            ev

                        New _ ->
                            New title

                        Editing todo ->
                            Editing { todo | title = title }
            in
                ( nev, todos, Cmd.none )

        -- this is matched when there is an http error
        -- it gives us an Http.Error, but we don't need it,
        -- so we'll just use an underscore _ to denote that
        Fail _ ->
            -- disregard error; do nothing
            ( ev, todos, Cmd.none )

        -- fetch all success
        FetchAllDone res ->
            case res of
                Result.Ok newTodos ->
                    ( ev, newTodos, Cmd.none )
                Result.Err _ ->
                    ( ev, todos, Cmd.none )

        -- create success...merge in the new todo
        CreateDone res ->
            case res of
                Result.Ok todo ->
                    ( ev, Utils.mergeById todos todo, Cmd.none )
                Result.Err _ ->
                    ( ev, todos, Cmd.none )

        -- patch success...merge in the new todo
        PatchDone res ->
            case res of
                Result.Ok newTodo ->
                    ( ev, Utils.mergeById todos newTodo, Cmd.none )
                Result.Err _ ->
                    ( ev, todos, Cmd.none )

        -- delete success...remove the old todo
        DeleteDone res ->
            case res of
                Result.Ok todo ->
                    ( ev, Utils.removeById todos todo, Cmd.none )
                Result.Err _ ->
                    ( ev, todos, Cmd.none )

        -- this is dispatched whenever the "save" button is clicked
        CreateOrPatch ->
            let
                cmd =
                    case ev of
                        None ->
                            Cmd.none

                        -- create a new todo
                        New title ->
                            Todos.Commands.create title

                        -- patch an existing todo
                        Editing todo ->
                            Todos.Commands.patch todo

                -- exit edit view (using None) and give elm our command
                -- see note below in Complete
            in
                ( None, todos, cmd )

        -- this is matched when "Done is clicked"
        Complete todo ->
            let
                -- make the new todo
                newTodo =
                    { todo | completed = True }

                -- if we want optimistic updates, we can make the changes ourselves
                -- AND dispatch the patch command.
                -- newTodos = Utils.mergeById todos newTodo
                -- instead, we'll let PatchDone do the updating for us
                -- if this were a mobile application we might want
                -- to apply updates optimistically instead (since
                -- internet is usually slower)
                newTodos =
                    todos
            in
                ( ev, newTodos, Todos.Commands.patch newTodo )

        -- this is matched when "Revert" is clicked
        Revert todo ->
            let
                -- make the new todo
                newTodo =
                    { todo | completed = False }

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
            let
                cmds =
                    todos
                        -- filter completed todos
                        -- similar to clojure, we can use a "dot notation"
                        -- to make a field-accessing function (.completed)
                        |> List.filter .completed
                        -- attach a delete command to each
                        |> List.map Todos.Commands.delete
            in
                ( ev, todos, Cmd.batch cmds )
