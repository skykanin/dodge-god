module Util where
import Types
import Encrypt
import Decrypt
import Data.Aeson
import Data.ByteString.Char8 (pack, unpack)
import Data.ByteString.Lazy qualified as BSL

toScore :: String -> Maybe Score
toScore = decode . BSL.fromStrict . pack 

fromScore :: Score -> String
fromScore = unpack . BSL.toStrict . encode
