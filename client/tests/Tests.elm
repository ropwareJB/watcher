module Tests exposing (..)

import Test exposing (..)
import Expect
import Url exposing (Url(..), fromString)


all : Test
all =
    describe "A Test Suite"
        [ test "URL fromString" <|
            \_ ->
                Expect.equal StartPage (fromString "#DFfsd123@GSdsfW#ER")
        ]
