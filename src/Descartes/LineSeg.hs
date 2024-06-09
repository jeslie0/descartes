module Descartes.LineSeg (LineSeg, lineSeg, Descartes.LineSeg.initialPoint, Descartes.LineSeg.finalPoint, Descartes.LineSeg.length, draw) where

import Control.Exception (mask_)
import Data.Coerce (coerce)
import Descartes.Internal.Foreign.LineSeg (LineSeg_t, drawLineSeg, finalPoint, initialPoint, lineLength, lineSegDelete, lineSegNew)
import Descartes.Internal.Foreign.Point (pointDelete)
import Descartes.Internal.Point (Point (..))
import Foreign (ForeignPtr, newForeignPtr, withForeignPtr)
import Foreign.C.Types (CDouble (..))
import System.IO.Unsafe (unsafePerformIO)

-- | A straight line segment, defined by two points.
newtype LineSeg = LineSeg (ForeignPtr LineSeg_t)

instance Eq LineSeg where
  l1 == l2 =
    Descartes.LineSeg.initialPoint l1 == Descartes.LineSeg.initialPoint l2
      && Descartes.LineSeg.finalPoint l1 == Descartes.LineSeg.finalPoint l2

-- | A smart constructor for a line segment. Takes an initial and
-- final point and generates the line between them.
lineSeg :: Point -> Point -> LineSeg
lineSeg (Point frnP1) (Point frnP2) =
  LineSeg . unsafePerformIO . withForeignPtr frnP1 $
    \p1 -> withForeignPtr frnP2 $
      \p2 -> mask_ . newForeignPtr lineSegDelete $ lineSegNew p1 p2
{-# INLINE lineSeg #-}

-- | Extract the initial point of a line.
initialPoint :: LineSeg -> Point
initialPoint (LineSeg frnLine) =
  Point . unsafePerformIO . withForeignPtr frnLine $
    \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.LineSeg.initialPoint ptr
{-# INLINE initialPoint #-}

-- | Extract the final point of a line.
finalPoint :: LineSeg -> Point
finalPoint (LineSeg frnLine) =
  Point . unsafePerformIO . withForeignPtr frnLine $
    \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.LineSeg.finalPoint ptr
{-# INLINE finalPoint #-}

-- | Compute the length of a line.
length :: LineSeg -> Double
length (LineSeg frnLine) =
  unsafePerformIO . withForeignPtr frnLine $
    \ptr -> return . coerce . lineLength $ ptr
{-# INLINE length #-}

-- | Render a line in the active graphics window.
draw :: LineSeg -> IO ()
draw (LineSeg frnLine) =
  withForeignPtr frnLine drawLineSeg
{-# INLINE draw #-}
