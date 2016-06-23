module Main exposing (..)

import Html.App

import Models exposing (init)
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions)


-- this is the entry point into our application
-- notice how there is no mention of "Todo" anywhere!
-- everything having to do with Todos is modularized and encapsulated
main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions }
