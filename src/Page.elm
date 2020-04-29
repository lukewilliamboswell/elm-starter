module Page exposing (..)

import Browser
import Element exposing (..)


type Page
    = Start
    | CsvFile
    | Analysis


view :
    { pageTitle : String
    , headerView : Element msg
    , footerView : Element msg
    , pageContent : Element msg
    }
    -> Browser.Document msg
view { pageTitle, headerView, footerView, pageContent } =
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
