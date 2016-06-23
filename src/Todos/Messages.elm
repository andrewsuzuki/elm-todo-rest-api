module Todos.Messages exposing (..)

import Http

import Todos.Models exposing (Todo, TodoEditView)


-- messages relevant to todos
type Msg =
    NoOp

    | ShowEditView TodoEditView
    | ChangeTitle String

    | FetchAllDone (List Todo)
    | FetchAllFail Http.Error
    | CreateDone Todo
    | CreateFail Http.Error
    | PatchDone Todo
    | PatchFail Http.Error
    | DeleteDone Todo
    | DeleteFail Http.Error

    | CreateOrPatch
    | Complete Todo
    | Revert Todo
    | Patch Todo
    | Delete Todo
    | DeleteCompleted
