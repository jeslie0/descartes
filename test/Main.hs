module Main (main) where

import qualified Descartes as D

main :: IO ()
main = do
  D.openGraphics
  p1 <- D.getPoint
  p2 <- D.getPoint
  D.setColour D.Red
  D.fillRectangle $ D.rectangle p1 p2
  D.closeGraphics
