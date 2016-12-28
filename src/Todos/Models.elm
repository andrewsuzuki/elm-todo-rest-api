module Todos.Models exposing (..)

-- this is the model for a single Todo.
-- note that the root Model has little knowledge on what a Todo "is";
-- it is encapsulated within the Todos namespace


type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    }



-- this is a union type representing the possible states of the edit view
-- (nothing, new todo, or editing an existing todo)


type TodoEditView
    = -- if None, then just show the "Create New Todo" button
      None
      -- the String here represents the value currently in the text box
    | New String
      -- similar, but here it's the Todo.title that holds the text box value
    | Editing Todo
