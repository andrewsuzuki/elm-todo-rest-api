module Todos.Models exposing (..)


type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    }

dummyTodo : Todo
dummyTodo =
    Todo 0 "my first todo" False
