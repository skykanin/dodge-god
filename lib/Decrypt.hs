module Decrypt (decrypt) where

import Data.Bits (xor)
import Data.ByteString.Base64.Lazy qualified as B64
import Data.ByteString.Lazy qualified as BSL
import Data.Word (Word8)
import Codec.Compression.Zlib.Internal

decrypt :: Word8 -> BSL.ByteString -> Either DecompressError BSL.ByteString
decrypt key =
    foldDecompressStreamWithInput (fmap . BSL.append . BSL.fromStrict)
                                  Right
                                  Left
                                  (decompressST zlibFormat defaultDecompressParams)
    . BSL.map (`xor` key)
    . B64.decodeLenient
