module UI exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes


non : Element.Attribute msg
non =
    Html.Attributes.classList [] |> Element.htmlAttribute


modal : Element msg -> Element.Attribute msg
modal content =
    content
        |> el
            [ centerX
            , centerY
            , width shrink
            , height shrink
            , Background.color (rgba255 255 255 255 0.95)
            , Border.width 1
            , Border.rounded 5
            , padding 20
            ]
        |> el
            [ width fill
            , height fill
            , Background.color (rgba255 0 0 0 0.5)
            ]
        |> inFront


buttonViewDeactivated : String -> Element msg
buttonViewDeactivated label =
    Input.button
        [ padding 5
        , Border.width 1
        , Background.color (rgb255 180 100 100)
        ]
        { onPress = Nothing
        , label = el [] (text label)
        }


buttonView : String -> msg -> Element msg
buttonView label clickHandler =
    Input.button
        [ padding 5
        , Border.width 1
        , Background.color (rgb255 100 180 100)
        ]
        { onPress = Just clickHandler
        , label = el [] (text label)
        }
