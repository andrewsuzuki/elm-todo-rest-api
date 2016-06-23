module Utils exposing (..)

import Json.Decode
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


-- issue a PATCH request
patch : Json.Decode.Decoder value -> String -> Http.Body -> Platform.Task Http.Error value
patch decoder url body =
    let request =
        { verb = "PATCH"
        , headers = [ ("Content-Type", "application/json") ]
        , url = url
        , body = body
        }
    in
        Http.fromJson decoder (Http.send Http.defaultSettings request)
