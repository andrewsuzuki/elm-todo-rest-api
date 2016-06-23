module Messages exposing (..)

import Todos.Messages

-- this is our "root" Msg, a union type representing
-- the different actions that can be applied to the app state
type Msg =
    -- "no operation" = do nothing
    NoOp
    -- Todos.Messages.Msg is a whole nother Msg specific to Todos
    | TodosMsg Todos.Messages.Msg
