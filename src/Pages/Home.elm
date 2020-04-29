module Pages.Home exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Store exposing (Store)
import UI


type Model
    = NothingHereYet Store


init : Store -> ( Model, Cmd Msg )
init store =
    ( NothingHereYet store
    , Cmd.none
    )


type Msg
    = NothingHereYetMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( _, _ ) ->
            ( model, Cmd.none )


view : Model -> Element Msg
view model =
    case model of
        NothingHereYet _ ->
            column
                [ width fill
                , height fill
                ]
                [ UI.buttonView "My Button" NothingHereYetMsg
                , el [ padding 20, centerX, centerY ] (text "Content")
                ]


toStore : Model -> Store
toStore model =
    case model of
        NothingHereYet store ->
            store
