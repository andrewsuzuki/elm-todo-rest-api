module Todos.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))

import Todos.Models exposing (Todo)
import Todos.Messages exposing (Msg (FetchAllFail, FetchAllDone))

-- for a better introduction to commands, tasks, and Json.Decode, see here:
-- http://www.elm-tutorial.org/en/06-fetching-resources/04-players-cmds.html

-- fetch all todos
fetchAll : Cmd Msg
fetchAll =
    Http.get todosDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


-- the static url we get the todos from
fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/todos"


-- json decoder for todos list
todosDecoder : Decode.Decoder (List Todo)
todosDecoder =
    Decode.list todoDecoder


-- json decoder for single todo
todoDecoder : Decode.Decoder Todo
todoDecoder =
    Decode.object3 Todo
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("completed" := Decode.bool)
