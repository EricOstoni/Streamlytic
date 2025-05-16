module EarthquakeData where

import Data.Aeson
import qualified Data.ByteString.Lazy as L
import Earthquake

-- | API URL
apiurl :: String
apiurl = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2000-05-01&endtime=2025-05-16&minmagnitude=2.5&minlatitude=42.0&maxlatitude=47.0&minlongitude=13.0&maxlongitude=20.0"

-- | Funkcija koja pars JSON podatke
parseEarthquakeData :: L.ByteString -> Either String [Earthquake]
parseEarthquakeData jsonData =
  case eitherDecode jsonData of
    Left err -> Left err
    Right response -> Right (features response)
