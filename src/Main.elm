module Main exposing (..)

import Html.App as Html

import Models exposing (init)
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions)


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions }
