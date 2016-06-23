module Todos.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))

import Todos.Models exposing (Todo)
import Todos.Messages exposing (Msg (FetchAllFail, FetchAllDone))


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/todos"


collectionDecoder : Decode.Decoder (List Todo)
collectionDecoder =
    Decode.list todoDecoder


todoDecoder : Decode.Decoder Todo
todoDecoder =
    Decode.object3 Todo
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("completed" := Decode.bool)
