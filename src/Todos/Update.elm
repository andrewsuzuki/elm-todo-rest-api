module Todos.Update exposing (..)

import Todos.Messages exposing (Msg (NoOp, FetchAllDone, FetchAllFail))
import Todos.Models exposing (Todo)


update : Msg -> List Todo -> (List Todo, Cmd Msg)
update msg todos =
    case msg of
        NoOp ->
            (todos, Cmd.none)

        FetchAllDone newTodos ->
            ( newTodos, Cmd.none )

        FetchAllFail error ->
            ( todos, Cmd.none )
