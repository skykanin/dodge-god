module Server (startServer) where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Aeson
import Data.Text.Lazy (pack)
import Data.Word
import Decrypt
import Types
import Web.Scotty
import Encrypt
import Data.Text.Lazy.Encoding (encodeUtf8, decodeUtf8)
import Network.HTTP.Types (status400, status200)
import Control.Exception (SomeException)
import Control.Monad.Catch (catch, try)
import Data.ByteString.Lazy (ByteString)

startServer :: Int -> Word8 -> IO ()
startServer port key =
  scotty port $ do
    get "/:word" $ do
      beam <- param "word"
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
    post "/" $ do 
      p <- params
      handle p key

handle p key = 
  case lookup "s" p of
    Just r -> parseSubmission r key
    _ -> raiseStatus status400 "submission error"

parseSubmission r key = do
  let d = decrypt key $ encodeUtf8 r
  let handler = (\_ -> raiseStatus status400 "decrypt error") :: SomeException -> ActionM ()

  catch (raiseStatus status200 $ decodeUtf8 d) handler


-- liftIO . print . decode @ScoreSubmission . 
