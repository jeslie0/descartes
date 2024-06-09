module Descartes.Internal.Point (Point (..), x, y) where

import Descartes.Internal.Foreign.Point (Point_t, pointXCoord, pointYCoord)
import Foreign (ForeignPtr, withForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

newtype Point = Point (ForeignPtr Point_t)

x :: Point -> Int
x (Point frnPtr) =
  unsafePerformIO . withForeignPtr frnPtr $ return . fromIntegral . pointXCoord

y :: Point -> Int
y (Point frnPtr) =
  unsafePerformIO . withForeignPtr frnPtr $ return . fromIntegral . pointYCoord

instance Show Point where
  show point = "(" <> show (x point) <> ", " <> show (y point) <> ")"

instance Eq Point where
  p1 == p2 = (x p1 == x p2) && (y p1 == y p2)
