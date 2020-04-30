module UI.Story exposing (..)

import Element exposing (Element)


type alias Story msg =
    { name : String
    , views : List ( String, Element msg )
    }
