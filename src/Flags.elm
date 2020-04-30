module Flags exposing (Flags, decoder, empty)

import Json.Decode as D


type alias Flags =
    { someString : String
    , someInt : Int
    , someFloat : Float
    }

empty : Flags
empty =
    { someString = ""
    , someInt = 1
    , someFloat = 0.1
    }


decoder : D.Decoder Flags
decoder =
    D.map3 Flags
        (D.field "someString" D.string)
        (D.field "someInt" D.int)
        (D.field "someFloat" D.float)


