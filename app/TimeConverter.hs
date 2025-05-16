module TimeConverter (convertTimestamp) where

import Data.Time.Clock.POSIX (posixSecondsToUTCTime)
import Data.Time.Format (defaultTimeLocale, formatTime)

convertTimestamp :: Integer -> String
convertTimestamp timestamp =
  formatTime defaultTimeLocale "%Y-%m-%d %H:%M:%S" time
  where
    time = posixSecondsToUTCTime (fromIntegral timestamp / 1000)
