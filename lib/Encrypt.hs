module Encrypt (encrypt) where

import Codec.Compression.Zlib (compress)
import Data.ByteString.Char8 qualified as BS
import Data.ByteString.Base64 qualified as B64 
import Data.ByteString.Lazy qualified as BSL
import Data.Bits (xor)
import Data.Aeson (encode)
import Data.Word (Word8)
import Types

encrypt :: Word8 -> Score -> String
encrypt key input = BS.unpack b
  where
    s = encode input
    z = compress s
    x = BSL.map (`xor` key) z
    b = B64.encode $ BSL.toStrict x
