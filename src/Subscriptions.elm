module Subscriptions exposing (..)

import Models exposing (Model)
import Messages exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
