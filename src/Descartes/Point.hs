module Descartes.Point (Point, point, x, y, Descartes.Point.getPoint) where

import Control.Exception (mask_)
import Descartes.Internal.Foreign.Point (getPoint, pointDelete, pointNew, pointXCoord, pointYCoord)
import Descartes.Internal.Point (Point (..))
import Foreign (newForeignPtr, withForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

point :: Int -> Int -> Point
point xVal yVal =
  Point . unsafePerformIO . mask_ $ newForeignPtr pointDelete (pointNew (fromIntegral xVal) (fromIntegral yVal))

x :: Point -> Int
x (Point frnPtr) =
  unsafePerformIO . withForeignPtr frnPtr $ return . fromIntegral . pointXCoord

y :: Point -> Int
y (Point frnPtr) =
  unsafePerformIO . withForeignPtr frnPtr $ return . fromIntegral . pointYCoord

getPoint :: IO Point
getPoint = do
  p <- Descartes.Internal.Foreign.Point.getPoint
  frnPtr <- mask_ $ newForeignPtr pointDelete p
  return $ Point frnPtr
