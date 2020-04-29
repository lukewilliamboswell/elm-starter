port module Ports exposing (..)


port outboundMsg : String -> Cmd msg


port inboundMsg : (String -> msg) -> Sub msg
