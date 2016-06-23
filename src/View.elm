module View exposing (..)

import Html exposing (..)

import Models exposing (Model)
import Messages exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [text (toString model.count)]
        ]
