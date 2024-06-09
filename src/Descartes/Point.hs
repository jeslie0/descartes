module Descartes.Point (Point, point, x, y, Descartes.Point.getPoint) where

import Control.Exception (mask_)
import Descartes.Internal.Foreign.Point (getPoint, pointDelete, pointNew)
import Descartes.Internal.Point (Point (..), x, y)
import Foreign (newForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

point :: Int -> Int -> Point
point xVal yVal =
  Point . unsafePerformIO . mask_ $ newForeignPtr pointDelete (pointNew (fromIntegral xVal) (fromIntegral yVal))

getPoint :: IO Point
getPoint = do
  p <- Descartes.Internal.Foreign.Point.getPoint
  frnPtr <- mask_ $ newForeignPtr pointDelete p
  return $ Point frnPtr
