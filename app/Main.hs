module Main where

import Earthquake (Earthquake (..))
import EarthquakeData (apiurl, parseEarthquakeData)
import Network.HTTP.Simple (getResponseBody, httpLBS, parseRequest)
import TimeConverter (convertTimestamp)

printEarthquake :: Earthquake -> IO ()
printEarthquake eq = do
  putStrLn "-----------------------------"
  putStrLn $ "Lokacija: " ++ place eq
  putStrLn $ "Magnituda: " ++ show (mag eq)
  putStrLn $ "Vrijeme: " ++ convertTimestamp (time eq)
  putStrLn $ "Više informacija: " ++ url eq
  putStrLn "-----------------------------"

main :: IO ()
main = do
  putStrLn "Dohvaćam podatke o potresima..."

  -- Kreiraj HTTP request
  request <- parseRequest apiurl

  -- Pošalji HTTP zahtjev i preuzmi odgovor
  response <- httpLBS request
  let responseBody = getResponseBody response

  -- Parsiranje JSON podataka
  let result = parseEarthquakeData responseBody

  -- Ispis rezultata
  case result of
    Left err -> putStrLn $ "Greška: " ++ err
    Right earthquakes -> mapM_ printEarthquake earthquakes
