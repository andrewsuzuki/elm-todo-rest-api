module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg)


-- these are our "root" subscriptions,
-- but we don't need any for this application.
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
