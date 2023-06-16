module Main exposing (..)

import Browser
import Html.Attributes exposing (placeholder, style)
import Html exposing (Html, button, text, section, main_, ul, li, input, h1, Attribute)
import Html.Events exposing (onClick, onInput)


type alias Item =
    { id : Int
    , content : String
    }


type alias Model =
    { items : List Item
    , newItem : String
    , nextId : Int
    }


type Msg
    = Add
    | Delete Int
    | UpdateNewItem String
    | Clear


init : Model
init =
    { items = []
    , newItem = ""
    , nextId = 1
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            let
                newItem =
                    { id = model.nextId
                    , content = model.newItem
                    }

                updatedItems =
                    newItem :: model.items
            in
            { model | items = updatedItems, newItem = "", nextId = model.nextId + 1}

        Delete itemId ->
            { model | items = List.filter (\item -> item.id /= itemId) model.items }

        UpdateNewItem newInput ->
            { model | newItem = newInput }

        Clear ->
            {model | items = []}


mainStyle : List (Attribute msg)
mainStyle = [ 
      style "border" "red solid 2px"
    , style "margin" "auto"
    , style "width" "30vw"
    , style "color" "black" 
    , style "display" "flex"
    , style "justify-content" "center"
    , style "padding" "1rem"
    ]


listStyle : List (Attribute msg)
listStyle = [
      style "display" "flex"
    , style "flex-direction" "column"
    , style "list-decoration" "none"
    , style "padding" "1rem"
    ]

listItemStyle : List (Attribute msg)
listItemStyle = [
      style "display" "flex"
    , style "flex-direction" "row"
    , style "border" "gray 1px dotted"
    , style "justify-content" "space-around"
    ]



buttonStyle : List (Attribute msg)
buttonStyle = []


view : Model -> Html Msg
view model =
    main_ mainStyle
    [ section [style "display" "flex", style "flex-direction" "column", style "gap" "1rem",  style "width" "30vw"]
            [ h1 [style "align-self" "center", style "text-decoration" "underline dotted"] [ text "ToDo List"]
            , input [onInput UpdateNewItem
                , placeholder "Add Item" 
                , Html.Attributes.value model.newItem]
                []
            , button [ onClick Add ] [ text "Add Item" ]
            , button [ onClick Clear ] [ text "Clear Items"]
            , ul listStyle (List.map itemToLi model.items)
            ]
        ]


itemToLi : Item -> Html Msg
itemToLi item =
    li listItemStyle
        [ text item.content
        , button [ onClick (Delete item.id) ] [ text "Delete" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }
