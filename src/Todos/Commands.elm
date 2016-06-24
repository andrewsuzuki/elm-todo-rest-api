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


-- take a todo id and return its endpoint
singleUrl : Int -> String
singleUrl id =
    String.join "/" [ resourceUrl, (toString id) ]


--
-- Decoding
--


-- yes, the json->elm conversion is a pain since a json string can be *anything*
-- and elm is a strongly typed programming language.

-- check out the json-to-elm project for writing quick json decoders
-- https://github.com/eeue56/json-to-elm


-- json decoder for todos list
todosDecoder : Json.Decode.Decoder (List Todo)
todosDecoder =
    -- notice how decoders are composable
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
-- Fetch
--


-- fetch all todos
fetchAll : Cmd Msg
fetchAll =
    Http.get todosDecoder resourceUrl
        |> Task.perform Fail FetchAllDone


--
-- Create
--


-- create todo
create : String -> Cmd Msg
create title =
    todoEncoder title False
        |> Utils.postJson todoDecoder resourceUrl
        |> Task.perform Fail CreateDone


--
-- Patch (Update)
--


-- patch todo
patch : Todo -> Cmd Msg
patch { id, title, completed } =
    todoEncoder title completed
        |> Utils.patchJson todoDecoder (singleUrl id)
        |> Task.perform Fail PatchDone


--
-- Delete
--


delete : Todo -> Cmd Msg
delete todo =
    Utils.delete todo (singleUrl todo.id)
        |> Task.perform Fail DeleteDone
