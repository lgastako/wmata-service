module WMATA.Data where

import Data.Aeson
import Data.Aeson.Types

resultToEither :: Result a -> Either String a
resultToEither (Success a) = Right a
resultToEither (Error err) = Left err

enhancedParse :: (Value -> Parser a) -> Value -> Result a
enhancedParse parseJson value =
  let result = parse parseJson value
   in case result of
        Success a -> Success a
        Error err -> Error (err <> ": " <> show value)
