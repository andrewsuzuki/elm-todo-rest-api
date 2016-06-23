module Todos.Messages exposing (..)

import Http

import Todos.Models exposing (Todo, TodoEditView)


-- messages relevant to todos
-- explanations can be found in the Todos.Update module
type Msg =
    NoOp

    | ShowEditView TodoEditView
    | ChangeTitle String

    | Fail Http.Error
    | FetchAllDone (List Todo)
    | CreateDone Todo
    | PatchDone Todo
    | DeleteDone Todo

    | CreateOrPatch
    | Complete Todo
    | Revert Todo
    | Patch Todo
    | Delete Todo
    | DeleteCompleted
