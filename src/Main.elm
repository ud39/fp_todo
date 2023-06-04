module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, section, main_, nav, header, footer)
import Html.Events exposing (onClick)

main : Program () Int Msg
main =
    Browser.sandbox { init = 0, update = update, view = view }

type Msg = Increment | Decrement


update : Msg -> Int -> Int
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view : Int -> Html Msg
view model =
    main_ []
    [section []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
    ]
