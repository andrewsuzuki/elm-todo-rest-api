module Todos.Messages exposing (..)

import Http

import Todos.Models exposing (Todo)

type Msg =
    NoOp
    | FetchAllDone (List Todo)
    | FetchAllFail Http.Error
