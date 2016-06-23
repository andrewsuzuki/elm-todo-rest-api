module Utils exposing (..)

import Json.Decode
import Json.Encode
import Http
import Task


-- this is a record type, which is essentially a composable record
-- see http://elm-lang.org/docs/records#record-types
-- this record type will match any record that has an integer id prop
type alias RecordWithId a =
    { a | id : Int }


-- merge a new RecordWithId into an existing list of RecordWithIds,
-- replacing the old RecordWithId(s) with the same id
mergeById : List (RecordWithId a) -> (RecordWithId a) -> List (RecordWithId a)
mergeById existing new =
    let
        merger =
            \a b ->
                if a.id == b.id then a else b
    in
        List.map (merger new) existing


-- issue a PATCH request using a Json.Encode.Value
patchJson : Json.Decode.Decoder value -> String -> Json.Encode.Value -> Platform.Task Http.Error value
patchJson decoder url json =
    let
        body =
            json
                -- encode json value into a String using 0 indent
                |> Json.Encode.encode 0
                -- convert String into an Http body
                |> Http.string

        request =
            { verb = "PATCH"
            , headers = [ ("Content-Type", "application/json") ]
            , url = url
            , body = body
            }
    in
        Http.fromJson decoder (Http.send Http.defaultSettings request)
