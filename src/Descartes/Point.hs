module Descartes.Point (Point, point, x, y, Descartes.Point.getPoint) where

import Control.Exception (mask_)
import Descartes.Internal.Foreign.Point (getPoint, pointDelete, pointNew)
import Descartes.Internal.Point (Point (..), x, y)
import Foreign (newForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

-- | Smart constructor for a point. It takes an x value and y value
-- and returns the point.
point :: Int -> Int -> Point
point xVal yVal =
  Point . unsafePerformIO . mask_ $ newForeignPtr pointDelete (pointNew (fromIntegral xVal) (fromIntegral yVal))

-- | Wait until the user clicks the mouse and return the point that
-- the user indicated.
getPoint :: IO Point
getPoint = do
  p <- Descartes.Internal.Foreign.Point.getPoint
  frnPtr <- mask_ $ newForeignPtr pointDelete p
  return $ Point frnPtr
