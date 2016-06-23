module Todos.Commands exposing (..)

import Http
import Task
import Json.Decode exposing ((:=))
import Json.Encode
import String

import Todos.Models exposing (Todo)
import Todos.Messages exposing (Msg (FetchAllFail, FetchAllDone, PatchFail, PatchDone))
import Utils

-- for a better introduction to commands, tasks, and Json.Decode, see here:
-- http://www.elm-tutorial.org/en/06-fetching-resources/04-players-cmds.html


resourceUrl : String
resourceUrl =
    "http://localhost:4000/todos"


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
    Http.get todosDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone



-- the static url we get the todos from
fetchAllUrl : String
fetchAllUrl =
    resourceUrl


--
-- Patching (Updates)
--


-- patch todo
patch : Todo -> Cmd Msg
patch { id, title, completed } =
    todoEncoder title completed
        |> Json.Encode.encode 0
        |> Http.string
        |> Utils.patch todoDecoder (patchUrl id)
        |> Task.perform PatchFail PatchDone


patchUrl : Int -> String
patchUrl id =
    String.join "/" [ resourceUrl, (toString id) ]


--
-- Deleting
--


-- TODO
