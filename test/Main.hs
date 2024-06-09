module Main (main, run) where

import Descartes qualified as D
import Control.Monad (when, forM_)
import Data.Complex qualified as C
import Data.Functor ((<&>))

main :: IO ()
main =
  putStrLn "Test succeeded"

run :: IO ()
run = D.withGraphics $ do
  D.setColour D.Blue

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

  D.setColour D.Green
  forM_ makeHexagon D.draw

  D.setColour D.Red
  makePath Nothing



makePath :: Maybe D.Point -> IO ()
makePath Nothing = D.getPoint >>= \p -> makePath (Just p)
makePath (Just p) = do
  p' <- D.getPoint
  D.draw $ D.lineSeg p p'
  makePath (Just p')

joinPoints :: [D.Point] -> [D.LineSeg]
joinPoints [] = []
joinPoints [p] = []
joinPoints (p1:p2:ps) = D.lineSeg p1 p2 : joinPoints (p2:ps)

makeHexagon :: [D.LineSeg]
makeHexagon =
  let
    scale f = round $ 166 * (f + 1.5)

    -- We use 7 here so that the last point is equal to the first.
    powers :: [C.Complex Float] =
      take 7 $ iterate (\ z -> z * C.mkPolar 1 (pi / 3)) (1.0 C.:+ 0)

    points :: [D.Point] =
      powers <&> \ z -> D.point (scale . C.realPart $ z) (scale . C.imagPart $ z)

  in joinPoints points
