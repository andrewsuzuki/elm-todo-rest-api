module Todos.Update exposing (..)

import Todos.Messages exposing (Msg (..))
import Todos.Models exposing (Todo)
import Todos.Commands
import Utils


-- handle messages relevant to model.todos
update : Msg -> List Todo -> (List Todo, Cmd Msg)
update msg todos =
    case msg of
        NoOp ->
            (todos, Cmd.none)

        FetchAllDone newTodos ->
            ( newTodos, Cmd.none )

        FetchAllFail error ->
            ( todos, Cmd.none )

        PatchDone newTodo ->
            ( Utils.mergeById todos newTodo, Cmd.none )

        PatchFail error ->
            ( todos, Cmd.none )

        Complete todo ->
            let
                newTodo = { todo | completed = True }

                -- if we want optimistic updates, we can make the changes ourselves
                -- AND dispatch the patch command.
                -- newTodos = Utils.mergeById todos newTodo

                -- instead, we'll let PatchDone do the updating for us
                newTodos = todos
            in
                ( newTodos, Todos.Commands.patch newTodo )

        Revert todo ->
            let
                newTodo = { todo | completed = False }
                -- see note above in Complete
            in
                ( todos, Todos.Commands.patch newTodo )

        -- this is a generic Patch for a todo that has already been altered
        Patch todo ->
            -- see note above in Complete
            ( todos, Todos.Commands.patch todo )
