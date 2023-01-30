module Main where

import Decrypt
import Encrypt
import Test.Tasty
import Test.Tasty.HUnit
import Types
import Util
import Data.Maybe (isJust)

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Tests"
    [ testCase "decrypt" $ input @=? (decrypt key encrypted)
    , testCase "encrypt" $ encrypted @=? (encrypt key input)
    , testCase "decrypt == encrypted" $ input @=? (decrypt key $ encrypt key input)
    , testCase "encrypt" $ encrypted @=? (encrypt key input)
    , testCase "toScore" $ True @=? (isJust $ toScore score)
    ]
 where
  key = 123
  input = "123"
  encrypted = "A+dIT0l9e3pWe+w="
  score = "{\"name\"=\"test\", \"mode\"=\"mouse\", \"version\"=1.0, \"dodge\"=44.0, \"startTime\"=\"10.01.2023\", \"endTime\"=\"11.01.2023\", \"time\"=22.0}"
