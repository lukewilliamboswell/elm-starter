module UI.Color exposing
    ( AppColor(..)
    , Grade(..)
    , Modifier(..)
    , background
    , border
    , convert
    , storyColorPallet
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import UI.Story exposing (Story)


type AppColor
    = Black
    | White
    | Aluminium Grade
    | Butter Modifier
    | Orange Modifier
    | Chocolate Modifier
    | Chameleon Modifier
    | SkyBlue Modifier
    | Plum Modifier
    | ScarletRed Modifier


type Modifier
    = Highlight
    | Normal
    | Shadow


type Grade
    = GradeOne
    | GradeTwo
    | GradeThree
    | GradeFour
    | GradeFive
    | GradeSix



-- COLORS


convert : AppColor -> Element.Color
convert appColor =
    case appColor of
        Black ->
            rgb255 0 0 0

        White ->
            rgb255 255 255 255

        Aluminium grade ->
            aluminiumColors grade

        Butter Highlight ->
            rgb255 252 234 79

        Butter Normal ->
            rgb255 237 212 0

        Butter Shadow ->
            rgb255 196 160 0

        Orange Highlight ->
            rgb255 252 175 62

        Orange Normal ->
            rgb255 254 121 0

        Orange Shadow ->
            rgb255 206 92 0

        Chocolate Highlight ->
            rgb255 233 185 110

        Chocolate Normal ->
            rgb255 193 125 17

        Chocolate Shadow ->
            rgb255 143 89 2

        Chameleon Highlight ->
            rgb255 138 226 52

        Chameleon Normal ->
            rgb255 115 210 22

        Chameleon Shadow ->
            rgb255 78 154 6

        SkyBlue Highlight ->
            rgb255 114 159 207

        SkyBlue Normal ->
            rgb255 52 101 164

        SkyBlue Shadow ->
            rgb255 32 74 135

        Plum Highlight ->
            rgb255 173 127 168

        Plum Normal ->
            rgb255 117 80 123

        Plum Shadow ->
            rgb255 92 53 102

        ScarletRed Highlight ->
            rgb255 239 41 41

        ScarletRed Normal ->
            rgb255 204 0 0

        ScarletRed Shadow ->
            rgb255 164 0 0


aluminiumColors : Grade -> Element.Color
aluminiumColors grade =
    case grade of
        GradeOne ->
            rgb255 238 238 236

        GradeTwo ->
            rgb255 211 215 207

        GradeThree ->
            rgb255 186 189 182

        GradeFour ->
            rgb255 136 138 133

        GradeFive ->
            rgb255 85 87 83

        GradeSix ->
            rgb255 46 52 54



-- STORIES


storyColorPallet : Story msg
storyColorPallet =
    { name = "All the colors!"
    , views =
        [ ( "Black", colorSquare Black )
        , ( "White", colorSquare White )
        , ( "Aluminium Grades 1-6"
          , row [ spacing 10 ]
                [ colorSquare (Aluminium GradeOne)
                , colorSquare (Aluminium GradeTwo)
                , colorSquare (Aluminium GradeThree)
                , colorSquare (Aluminium GradeFour)
                , colorSquare (Aluminium GradeFive)
                , colorSquare (Aluminium GradeSix)
                ]
          )
        , ( "Butter", row [ spacing 10 ] [ colorSquare (Butter Highlight), colorSquare (Butter Normal), colorSquare (Butter Shadow) ] )
        , ( "Orange", row [ spacing 10 ] [ colorSquare (Orange Highlight), colorSquare (Orange Normal), colorSquare (Orange Shadow) ] )
        , ( "Chocolate", row [ spacing 10 ] [ colorSquare (Chocolate Highlight), colorSquare (Chocolate Normal), colorSquare (Chocolate Shadow) ] )
        , ( "Chameleon", row [ spacing 10 ] [ colorSquare (Chameleon Highlight), colorSquare (Chameleon Normal), colorSquare (Chameleon Shadow) ] )
        , ( "SkyBlue", row [ spacing 10 ] [ colorSquare (SkyBlue Highlight), colorSquare (SkyBlue Normal), colorSquare (SkyBlue Shadow) ] )
        , ( "Plum", row [ spacing 10 ] [ colorSquare (Plum Highlight), colorSquare (Plum Normal), colorSquare (Plum Shadow) ] )
        , ( "ScarletRed", row [ spacing 10 ] [ colorSquare (ScarletRed Highlight), colorSquare (ScarletRed Normal), colorSquare (ScarletRed Shadow) ] )
        ]
    }



-- |> story "Pallet"
-- |> Story.withDescription "This pallet shows the basic colours used everywhere."


colorSquare : AppColor -> Element msg
colorSquare appColor =
    el
        [ width (px 50)
        , height (px 50)
        , Background.color <| convert appColor
        , Border.color <| convert Black
        , Border.width 1
        ]
        (text "")


border : AppColor -> Element.Attribute msg
border appColor =
    appColor
        |> convert
        |> Border.color


background : AppColor -> Element.Attribute msg
background appColor =
    appColor
        |> convert
        |> Background.color
