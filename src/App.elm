module App exposing (..)

import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Page
import Pages.Blank
import Pages.Home
import Pages.NotFound
import Route exposing (Route)
import Store exposing (Store)
import Url exposing (Url)


main : Program () Model Msg
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
    | Home Pages.Home.Model


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    changeRouteTo
        (Route.fromUrl url)
        (Redirect (Store.init key))


toStore : Model -> Store
toStore model =
    case model of
        Redirect store ->
            store

        NotFound store ->
            store

        Home subModel ->
            Pages.Home.toStore subModel


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( UserChangedUrl _, _ ) ->
            ( model, Cmd.none )

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

        Home subModel ->
            Page.view
                { pageTitle = "Home"
                , headerView = el [ width fill, Background.color (rgba255 255 0 0 0.5) ] (el [ padding 20, centerX ] (text "Header"))
                , footerView = el [ width fill, Background.color (rgba255 0 0 255 0.5) ] (el [ padding 20, centerX ] (text "Footer"))
                , pageContent = Element.map GotHomeMsg (Pages.Home.view subModel)
                }
