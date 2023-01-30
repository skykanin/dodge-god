module Encrypt (encrypt) where

import Codec.Compression.Zlib (compress)
import Data.ByteString.Char8 qualified as BS
import Data.ByteString.Base64 qualified as B64 
import Data.ByteString.Lazy qualified as BSL
import Data.Bits (xor)
import Data.Word (Word8)

encrypt :: Word8 -> String -> String
encrypt key = 
  BS.unpack .
  B64.encode . BSL.toStrict .
  BSL.map (`xor` key) .
  compress . BSL.fromStrict . BS.pack
