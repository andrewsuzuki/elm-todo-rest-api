module Models exposing (..)

import Messages exposing (Msg)


type alias Model =
    { count : Int }


init : (Model, Cmd Msg)
init =
    (Model 0, Cmd.none)
