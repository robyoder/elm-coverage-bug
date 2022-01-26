module Example exposing (..)

import Expect exposing (Expectation)
import Main exposing (add)
import Test exposing (..)


suite : Test
suite =
    describe "Main"
        [ test "add" testAdd
        ]


testAdd : a -> Expectation
testAdd _ =
    Expect.equal (add 1 2) 3
