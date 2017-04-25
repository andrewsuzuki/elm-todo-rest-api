module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg)


-- these are our "root" subscriptions,
-- but we don't need any for this application.


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- for a good intro to subscriptions, see the elm guide and its "Time" example:
-- http://guide.elm-lang.org/architecture/effects/time.html
