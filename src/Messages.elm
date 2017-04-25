module Messages exposing (..)

import Todos.Messages


-- this is our "root" Msg, a union type representing
-- the different actions that can be applied to the entire app state.
-- any "tag" or "subtype" in a union type can have associated data
-- additionally, any tag then becomes a function that accepts
-- that same associated data. this can be seen in action
-- later in the application.


type Msg
    = -- "no operation" = do nothing. it's a good thing to include
      -- in any Msg type you create -- think of it as the "control"
      -- in a research project
      NoOp
      -- since we want to keep our app modular, we want to forward
      -- anything having to do with the concept of todos to a
      -- different Msg module, in this case Todos.Messages.Msg.
      -- since Todos.Messages.Msg is a union type itself,
      -- we need to surround it with TodosMsg here to prevent
      -- naming collisions. For example, if I had a NoOp in
      -- Todos.Message.Msg, then that would collide with the NoOp
      -- in *this* Msg. Therefore, it needs to be wrapped.
    | TodosMsg Todos.Messages.Msg
