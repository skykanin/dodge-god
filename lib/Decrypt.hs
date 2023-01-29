module Decrypt (decrypt) where

import Codec.Compression.Zlib (decompress)
import Data.ByteString.Char8 qualified as BS
import Data.ByteString.Base64 qualified as B64 
import Data.ByteString.Lazy qualified as BSL
import Data.Bits (xor)
import Data.Either (fromRight)
import Data.Aeson 
import Data.Word
import Types

decrypt :: Word8 -> String -> Maybe Score
decrypt key input = decode decompressed
  where 
    buf = BSL.fromStrict $ fromRight BS.empty $ B64.decode $ BS.pack input
    decrypted = BSL.map (`xor` key) buf
    decompressed = decompress decrypted
