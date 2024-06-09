module Descartes.Internal.Point (Point (..), x, y) where

import Descartes.Internal.Foreign.Point (Point_t, pointXCoord, pointYCoord)
import Foreign (ForeignPtr, withForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

-- | A point on the x-y plane. While there is no hard limit on the
-- bounds, the graphics window is bound in both the x and y direction
-- by 500px.
newtype Point = Point (ForeignPtr Point_t)

-- | Extract the x-coordinate from the point.
x :: Point -> Int
x (Point frnPtr) =
  unsafePerformIO . withForeignPtr frnPtr $ return . fromIntegral . pointXCoord

{-# INLINE x #-}

-- | Extract the y-coordinate from the point.
y :: Point -> Int
y (Point frnPtr) =
  unsafePerformIO . withForeignPtr frnPtr $ return . fromIntegral . pointYCoord

{-# INLINE y #-}

instance Show Point where
  show point = "(" <> show (x point) <> ", " <> show (y point) <> ")"

instance Eq Point where
  p1 == p2 = (x p1 == x p2) && (y p1 == y p2)
