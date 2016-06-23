module Utils exposing (..)

import Json.Decode
import Json.Encode
import Http
import Task


-- this is a record type, which is essentially a composable record
-- see http://elm-lang.org/docs/records#record-types
-- it says "i match any record as long as it has an integer id"
type alias RecordWithId a =
    { a | id : Int }


-- merge a new RecordWithId into an existing list of RecordWithIds,
-- replacing the old RecordWithId(s) that have the same id,
-- or if there aren't any existing then append it to the end
mergeById : List (RecordWithId a) -> (RecordWithId a) -> List (RecordWithId a)
mergeById existing new =
    let
        -- this is the reducing function
        merger =
            \candidate (found, els) ->
                if new.id == candidate.id then
                    -- mark as found, disregard old (candidate) by conssing new
                    ( True, new :: els )
                else
                    -- doesn't match, so just include it as-is
                    ( found, candidate :: els )

        (found, coalesced) =
            -- foldl is the same as "reduce" in js, lisp, etc
            List.foldl merger (False, []) existing

        newListReversed =
            -- if a replacement wasn't already made, then just cons the new one
            if found then coalesced else new :: coalesced
    in
        -- since the cons operator (::) adds to the head of the list,
        -- our original list is now in reverse. let's reverse it back to normal
        List.reverse newListReversed

removeById : List (RecordWithId a) -> (RecordWithId a) -> List (RecordWithId a)
removeById existing target =
    let
        filterer =
            \a b ->
                a.id /= b.id
    in
        -- since functions in elm curry, we can use partial application
        -- to make a filterer that uses our target (filterer target)
        List.filter (filterer target) existing


-- issue a POST request using a Json.Encode.Value
postJson : Json.Decode.Decoder value -> String -> Json.Encode.Value -> Platform.Task Http.Error value
postJson decoder url json =
    let
        body =
            json
                -- encode json value into a String using 0 indent
                |> Json.Encode.encode 0
                -- convert String into an Http body
                |> Http.string

        request =
            { verb = "POST"
            , headers = [ ("Content-Type", "application/json") ]
            , url = url
            , body = body
            }
    in
        request
            |> Http.send Http.defaultSettings
            |> Http.fromJson decoder


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
        request
            |> Http.send Http.defaultSettings
            |> Http.fromJson decoder


-- issue a DELETE request
delete : a -> String -> Platform.Task Http.Error a
delete a url =
    let
        decoder =
            -- since the api returns an empty object on success,
            -- let's have the succes value be the value that was
            -- passed in originally so it can be used elsewhere
            -- to remove itself
            Json.Decode.succeed a

        request =
            { verb = "DELETE"
            , headers = []
            , url = url
            , body = Http.empty
            }
    in
        request
            |> Http.send Http.defaultSettings
            |> Http.fromJson decoder
