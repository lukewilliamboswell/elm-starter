module Store exposing
    ( Store
    , init
    , toKey
    )

import Browser.Navigation as Nav

type alias Store =
    { errors : List String
    , navKey : Nav.Key
    }


init : Nav.Key -> Store
init key =
    { errors = []
    , navKey = key
    }


toKey : Store -> Nav.Key
toKey { navKey } =
    navKey
