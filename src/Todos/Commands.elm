module Todos.Commands exposing (..)

import Http
import Task
import Json.Decode exposing ((:=))
import Json.Encode
import String

import Todos.Models exposing (Todo)
import Todos.Messages exposing (Msg (..))
import Utils


-- for a better introduction to commands, tasks, and Json.Decode, see here:
-- http://www.elm-tutorial.org/en/06-fetching-resources/04-players-cmds.html


resourceUrl : String
resourceUrl =
    "http://localhost:4000/todos"


singleUrl : Int -> String
singleUrl id =
    String.join "/" [ resourceUrl, (toString id) ]


--
-- Decoding
--


-- json decoder for todos list
todosDecoder : Json.Decode.Decoder (List Todo)
todosDecoder =
    Json.Decode.list todoDecoder


-- json decoder for single todo
todoDecoder : Json.Decode.Decoder Todo
todoDecoder =
    Json.Decode.object3 Todo
        ("id" := Json.Decode.int)
        ("title" := Json.Decode.string)
        ("completed" := Json.Decode.bool)


--
-- Encoding
--


todoEncoder : String -> Bool -> Json.Encode.Value
todoEncoder title completed =
    let
        encodings =
            [ ( "title", Json.Encode.string title )
            , ( "completed", Json.Encode.bool completed )
            ]
    in
        encodings
            |> Json.Encode.object


--
-- Fetching
--


-- fetch all todos
fetchAll : Cmd Msg
fetchAll =
    Http.get todosDecoder resourceUrl
        |> Task.perform FetchAllFail FetchAllDone


--
-- Patching (Updates)
--


-- patch todo
patch : Todo -> Cmd Msg
patch { id, title, completed } =
    todoEncoder title completed
        |> Utils.patchJson todoDecoder (singleUrl id)
        |> Task.perform PatchFail PatchDone


--
-- Deleting
--


delete : Todo -> Cmd Msg
delete todo =
    Utils.delete todo (singleUrl todo.id)
        |> Task.perform DeleteFail DeleteDone
