module Decrypt (decrypt) where

import Codec.Compression.Zlib qualified as Zlib
import Data.Bits (xor)
import Data.ByteString.Base64.Lazy qualified as B64
import Data.ByteString.Lazy qualified as BSL
import Data.Word (Word8)

decrypt :: Word8 -> BSL.ByteString -> BSL.ByteString
decrypt key =
  Zlib.decompress
    . BSL.map (`xor` key)
    . B64.decodeLenient
