module Pages.ApplicationError exposing (view)

import Browser exposing (Document)
import Element exposing (..)



-- VIEW


view : Document msg
view =
    { title = "Application Configuration Error"
    , body =
        [ text "Application Configuration Error; was not able to load applicaiton flags."
            |> el [ centerX, centerY ]
            |> layout [ width fill, height fill ]
        ]
    }
