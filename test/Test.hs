module Main where

import Decrypt
import Encrypt
import Test.Tasty
import Test.Tasty.HUnit

main :: IO()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests"
  [ testCase "encrypt == decrypt" $
      Just input @=? (encrypt key <$> decrypt key input)
  ]
  where
    key = 123
    input = "123"
