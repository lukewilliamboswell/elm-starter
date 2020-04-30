module Store exposing
    ( Store
    , init
    , toKey
    )

import Browser.Navigation as Nav
import Flags exposing (Flags)


type alias Store =
    { errors : List String
    , navKey : Nav.Key
    , flags : Flags
    }


init : Nav.Key -> Flags -> Store
init key flags =
    { errors = []
    , navKey = key
    , flags = flags
    }


toKey : Store -> Nav.Key
toKey { navKey } =
    navKey
