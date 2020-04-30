module Pages.StoryBoard exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page exposing (Page)
import Route
import Store exposing (Store)
import UI
import UI.Color as Color exposing (AppColor(..), Grade(..), Modifier(..))
import UI.Story exposing (Story)


type alias Model =
    { store : Store
    , stories : List (Story Msg)
    }


init : Store -> ( Model, Cmd Msg )
init store =
    ( { store = store
      , stories =
            [ Color.storyColorPallet
            ]
      }
    , Cmd.none
    )


type Msg
    = UserClickedNavigateHome


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserClickedNavigateHome ->
            ( model
            , Route.replaceUrl (model |> toStore |> Store.toKey) Route.Home
            )

        -- _ ->
        --     ( model, Cmd.none )


view : Model -> Page Msg
view model =
    Page.Standard
        { pageTitle = "Story Board"
        , headerView =
            row [ width fill, Background.color (rgba255 255 0 0 0.5) ]
                [ UI.buttonView "Home" UserClickedNavigateHome
                    |> el [ alignLeft, paddingXY 10 0  ]
                , el [ padding 20, centerX ] (text "Header")
                ]
        , footerView = el [ width fill, Background.color (rgba255 0 0 255 0.5) ] (el [ padding 20, centerX ] (text "Footer"))
        , pageContent = storiesTableView model
        }


storiesTableView : Model -> Element Msg
storiesTableView { stories } =
    stories
        |> List.map viewStory
        |> column
            [ width fill
            , height fill
            , spacing 20
            ]


viewStory : Story Msg -> Element Msg
viewStory story =
    table
        [ width fill
        , Border.width 10
        , Color.border (Butter Highlight)
        ]
        { data = story.views
        , columns =
            [ { header =
                    -- (Text.text "Story Line"
                    --     |> Text.withRole Text.Label
                    --     |> Text.withColor White
                    --     |> Text.view
                    -- )
                    el
                        [ Color.background (Butter Highlight)
                        , padding 10
                        , Font.bold
                        ]
                        (text "Story")
              , width = shrink
              , view =
                    \( label, _ ) ->
                        -- (Text.text label
                        --     |> Text.withRole Text.Label
                        --     |> Text.view
                        -- )
                        text label
                            |> el [ centerY ]
                            |> el
                                [ padding 5
                                , width fill
                                , height fill
                                , Border.width 1
                                , Color.border (Aluminium GradeOne)
                                ]
              }
            , { header =
                    -- (Text.text "Content View"
                    --     |> Text.withRole Text.Label
                    --     |> Text.withColor White
                    --     |> Text.view
                    -- )
                    text "Content"
                        |> el
                            [ width fill
                            , Color.background (Butter Highlight)
                            , padding 10
                            , Font.bold
                            ]
              , width = fill
              , view =
                    \( _, storyView ) ->
                        storyView
                            |> el [ width shrink, centerY ]
                            |> el
                                [ padding 5
                                , width fill
                                , height fill
                                , Border.width 1
                                , Color.border (Aluminium GradeOne)
                                ]
              }
            ]
        }


toStore : Model -> Store
toStore { store } =
    store
