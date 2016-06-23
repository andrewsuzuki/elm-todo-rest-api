module Todos.Models exposing (..)


-- this is the model for a single Todo.
-- note that the root Model has little knowledge on what a Todo "is";
-- it is encapsulated within the Todos namespace
type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    }
