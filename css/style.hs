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
    backgroundColor black
    "grid-template-rows" -: "1fr 1fr 1fr"
    let rot = deg 30
    transform (rotateX rot)
    background $
      linearGradient (angular rot)
        [ ( red    ,   0 )
        , ( yellow ,  40 )
        , ( blue   , 100 )
        ]
