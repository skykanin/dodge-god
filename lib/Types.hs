module Types (Score, Mode) where
import GHC.Generics (Generic)
import Data.Aeson

data Mode = Mouse | Keyboard 
  deriving (Show, Generic, ToJSON)

instance FromJSON Mode
  where 
    parseJSON (String "mouse") = pure Mouse
    parseJSON (String "keyboard") = pure Keyboard
    parseJSON _ = fail "unable to parse"

data Score = Score{
  name :: String,
  mode :: Mode,
  version :: Double,
  dodge :: Double,
  startTime :: String,
  endTime :: String,
  time :: Double
} deriving (Show, Generic, FromJSON, ToJSON)
