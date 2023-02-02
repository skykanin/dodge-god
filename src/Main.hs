module Main where

import Data.Word
import Server
import System.Environment (getEnv)

main :: IO ()
main = do
  port <- read @Int <$> getEnv "PORT"
  key <- read @Word8 <$> getEnv "KEY"
  startServer port key
