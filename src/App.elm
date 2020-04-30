module App exposing (..)

import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Flags
import Json.Decode
import Page
import Pages.ApplicationError
import Pages.Blank
import Pages.Home
import Pages.NotFound
import Pages.StoryBoard
import Route exposing (Route)
import Store exposing (Store)
import Url exposing (Url)


main : Program Json.Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UserClickedLink
        , onUrlChange = UserChangedUrl
        }



-- Model


type Model
    = Redirect Store
    | NotFound Store
    | ApplicationError Store
    | Home Pages.Home.Model
    | StoryBoard Pages.StoryBoard.Model


init : Json.Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init jsonFlags url key =
    case jsonFlags |> Json.Decode.decodeValue Flags.decoder of
        Ok flags ->
            changeRouteTo
                (Route.fromUrl url)
                (Redirect (Store.init key flags))

        Err _ ->
            ( ApplicationError (Store.init key Flags.empty), Cmd.none )


toStore : Model -> Store
toStore model =
    case model of
        Redirect store ->
            store

        NotFound store ->
            store

        ApplicationError store ->
            store

        Home subModel ->
            Pages.Home.toStore subModel

        StoryBoard subModel ->
            Pages.StoryBoard.toStore subModel


toKey : Model -> Nav.Key
toKey model =
    model
        |> toStore
        |> Store.toKey


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( NotFound (toStore model), Cmd.none )

        Just Route.Home ->
            Pages.Home.init (toStore model)
                |> updateWith Home GotHomeMsg

        Just Route.StoryBoard ->
            Pages.StoryBoard.init (toStore model)
                |> updateWith StoryBoard GotStoryBoardMsg


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )



-- Update


type Msg
    = UserChangedUrl Url
    | UserClickedLink Browser.UrlRequest
    | GotHomeMsg Pages.Home.Msg
    | GotStoryBoardMsg Pages.StoryBoard.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( UserChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( UserClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            ( model, Cmd.none )

                        Just _ ->
                            ( model, Cmd.none )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ( GotHomeMsg subMsg, Home subModel ) ->
            updateWith Home GotHomeMsg (Pages.Home.update subMsg subModel)

        ( GotStoryBoardMsg subMsg, StoryBoard subModel ) ->
            updateWith StoryBoard GotStoryBoardMsg (Pages.StoryBoard.update subMsg subModel)

        ( _, _ ) ->
            ( NotFound (toStore model), Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Browser.Document Msg
view model =
    case model of
        Redirect _ ->
            Pages.Blank.view

        NotFound _ ->
            Pages.NotFound.view

        ApplicationError _ ->
            Pages.ApplicationError.view

        Home subModel ->
            subModel
                |> Pages.Home.view
                |> Page.map GotHomeMsg
                |> Page.view

        StoryBoard subModel ->
            subModel
                |> Pages.StoryBoard.view
                |> Page.map GotStoryBoardMsg
                |> Page.view
