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

        ShowEditView nev ->
            ( nev, todos, Cmd.none )

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

        FetchAllDone newTodos ->
            ( ev, newTodos, Cmd.none )

        FetchAllFail error ->
            ( ev, todos, Cmd.none )

        CreateDone newTodo ->
            ( ev, Utils.mergeById todos newTodo, Cmd.none )

        CreateFail error ->
            ( ev, todos, Cmd.none )

        PatchDone newTodo ->
            ( ev, Utils.mergeById todos newTodo, Cmd.none )

        PatchFail error ->
            ( ev, todos, Cmd.none )

        DeleteDone todo ->
            ( ev, Utils.removeById todos todo, Cmd.none )

        DeleteFail error ->
            ( ev, todos, Cmd.none )

        CreateOrPatch ->
            let cmd =
                case ev of
                    None ->
                        Cmd.none
                    New title ->
                        Todos.Commands.create title
                    Editing todo ->
                        Todos.Commands.patch todo
            in ( None, todos, cmd )

        Complete todo ->
            let
                newTodo = { todo | completed = True }

                -- if we want optimistic updates, we can make the changes ourselves
                -- AND dispatch the patch command.
                -- newTodos = Utils.mergeById todos newTodo

                -- instead, we'll let PatchDone do the updating for us
                newTodos = todos
            in
                ( ev, newTodos, Todos.Commands.patch newTodo )

        Revert todo ->
            let
                newTodo = { todo | completed = False }
                -- see note above in Complete
            in
                ( ev, todos, Todos.Commands.patch newTodo )

        -- this is a generic Patch for a todo that has already been altered
        Patch todo ->
            -- see note above in Complete
            ( ev, todos, Todos.Commands.patch todo )

        Delete todo ->
            -- see note above in Complete
            ( ev, todos, Todos.Commands.delete todo )
