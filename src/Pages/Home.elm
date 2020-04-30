module Pages.Home exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page exposing (Page)
import Store exposing (Store)
import UI


type Model
    = SceneA Store
    | ModalView Store


init : Store -> ( Model, Cmd Msg )
init store =
    ( SceneA store
    , Cmd.none
    )


type Msg
    = UserClickedShowModalBtn
    | UserClickedHideModalBtn


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( UserClickedShowModalBtn, _ ) ->
            ( ModalView (toStore model), Cmd.none )

        ( UserClickedHideModalBtn, _ ) ->
            ( SceneA (toStore model), Cmd.none )



-- ( _, _ ) ->
--     ( model, Cmd.none )


view : Model -> Page Msg
view model =
    case model of
        SceneA _ ->
            Page.Default
                { pageTitle = "Home"
                , headerView = el [ width fill, Background.color (rgba255 255 0 0 0.5) ] (el [ padding 20, centerX ] (text "Header"))
                , footerView = el [ width fill, Background.color (rgba255 0 0 255 0.5) ] (el [ padding 20, centerX ] (text "Footer"))
                , pageContent =
                    column
                        [ width fill
                        , height fill
                        , spacing 20
                        ]
                        [ UI.buttonView "Show Modal" UserClickedShowModalBtn
                            |> el [ centerX, centerY ]
                        , el
                            [ padding 20
                            , centerX
                            , centerY
                            ]
                            (text "Insert text here...")
                        ]
                }

        ModalView _ ->
            Page.Modal
                { pageTitle = "Home"
                , headerView = el [ width fill, Background.color (rgba255 255 0 0 0.5) ] (el [ padding 20, centerX ] (text "Header"))
                , footerView = el [ width fill, Background.color (rgba255 0 0 255 0.5) ] (el [ padding 20, centerX ] (text "Footer"))
                , pageContent =
                    column
                        [ width fill
                        , height fill
                        ]
                        [ el [ padding 20, centerX ] (text "Showing a modal")
                        ]
                , modalContent =
                    column
                        [ padding 40
                        , spacing 20
                        ]
                        [ el [ padding 20, centerX, centerY ] (text "This is a modal dialog. Insert content here...")
                        , UI.buttonView "Hide Modal" UserClickedHideModalBtn
                            |> el [ centerX ]
                        ]
                }


toStore : Model -> Store
toStore model =
    case model of
        SceneA store ->
            store

        ModalView store ->
            store
