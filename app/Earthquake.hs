{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Earthquake where

import Data.Aeson
import GHC.Generics

-- | Model za parsiranje JSON-a unutar "features"
data Earthquake = Earthquake
  { mag :: Double,
    place :: String,
    time :: Integer,
    url :: String,
    title :: String
  }
  deriving (Show, Generic)

-- | Definicija kako parsirati JSON u naš model
instance FromJSON Earthquake where
  parseJSON = withObject "Earthquake" $ \obj -> do
    properties <- obj .: "properties"
    Earthquake
      <$> properties .: "mag"
      <*> properties .: "place"
      <*> properties .: "time"
      <*> properties .: "url"
      <*> properties .: "title"

-- | Model za parsiranje cijele liste "features"
newtype EarthquakeResponse = EarthquakeResponse
  { features :: [Earthquake]
  }
  deriving (Show, Generic)

instance FromJSON EarthquakeResponse
