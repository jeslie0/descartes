module Main (main) where

import Descartes qualified as D
import Control.Monad (when)

main :: IO ()
main = D.withGraphics $ do
  D.setColour D.Red

  putStrLn "Click twice to draw a line."
  p1 <- D.getPoint
  print p1
  p2 <- D.getPoint
  print p2
  D.draw $ D.lineSeg p1 p2

  when (p1 == p2) $ putStrLn "The two points are equal!"

  D.setColour D.Blue
  putStrLn "Click twice to draw a rectangle (bottom left, then top right)."
  bl <- D.getPoint
  tr <- D.getPoint

  D.fillRectangle $ D.rectangle bl tr

  makePath Nothing


makePath :: Maybe D.Point -> IO ()
makePath Nothing = D.getPoint >>= \p -> makePath (Just p)
makePath (Just p) = do
  p' <- D.getPoint
  D.draw $ D.lineSeg p p'
  makePath (Just p')
