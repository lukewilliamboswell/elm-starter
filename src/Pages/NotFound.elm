module Pages.NotFound exposing (view)

import Browser exposing (Document)
import Element exposing (Element)



-- VIEW


view : Document msg
view =
    { title = "Page Not Found"
    , body =
        [ Element.text "Error 404; the page you are looking for does not exist."
            |> Element.el [ Element.centerX, Element.centerY ]
            |> Element.layout [ Element.width Element.fill, Element.height Element.fill ]
        ]
    }
