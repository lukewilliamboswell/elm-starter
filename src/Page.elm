module Page exposing (..)

import Browser
import Element exposing (..)
import UI


type Page msg
    = Default
        { pageTitle : String
        , headerView : Element msg
        , footerView : Element msg
        , pageContent : Element msg
        }
    | Modal
        { pageTitle : String
        , headerView : Element msg
        , footerView : Element msg
        , pageContent : Element msg
        , modalContent : Element msg
        }


view : Page msg -> Browser.Document msg
view page =
    case page of
        Default { pageTitle, headerView, footerView, pageContent } ->
            { title = pageTitle
            , body =
                [ layout
                    [ width fill, height fill ]
                    (column
                        [ width fill, height fill ]
                        [ headerView, pageContent, footerView ]
                    )
                ]
            }

        Modal { pageTitle, headerView, footerView, pageContent, modalContent } ->
            { title = pageTitle
            , body =
                [ layout
                    [ width fill
                    , height fill
                    , UI.modal modalContent
                    ]
                    (column
                        [ width fill, height fill ]
                        [ headerView, pageContent, footerView ]
                    )
                ]
            }


map : (msgA -> msgB) -> Page msgA -> Page msgB
map handler page =
    case page of
        Default { pageTitle, headerView, footerView, pageContent } ->
            Default
                { pageTitle = pageTitle
                , headerView = Element.map handler headerView
                , footerView = Element.map handler footerView
                , pageContent = Element.map handler pageContent
                }

        Modal { pageTitle, headerView, footerView, pageContent, modalContent } ->
            Modal
                { pageTitle = pageTitle
                , headerView = Element.map handler headerView
                , footerView = Element.map handler footerView
                , pageContent = Element.map handler pageContent
                , modalContent = Element.map handler modalContent
                }
