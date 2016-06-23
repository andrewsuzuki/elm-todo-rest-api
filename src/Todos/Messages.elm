module Todos.Messages exposing (..)

import Http

import Todos.Models exposing (Todo)


-- messages relevant to todos
type Msg =
    NoOp
    | FetchAllDone (List Todo)
    | FetchAllFail Http.Error
    | PatchDone Todo
    | PatchFail Http.Error
    | Complete Todo
    | Revert Todo
    | Patch Todo
