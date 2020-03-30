-- Timestamp: Thu Dec 20 16:53:10 2018
{-# LANGUAGE OverloadedStrings #-}
import           Clay

main :: IO ()
main = putCss myStylesheet

myStylesheet :: Css
myStylesheet = star ? do
  backgroundColor white
  body ? do
    display grid
    "grid-template-rows" -: "1fr 2fr 1fr"
    header ? do
      display grid
      "grid-template-columns" -: "1fr 4fr 4fr"
      "grid-template-areas" -: "'logo . options'"
      ".logo" ? do
        "grid-area" -: "logo"
      ".options" ? do
        display flex
        "grid-area" -: "options"
