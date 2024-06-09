module Descartes.LineSeg (LineSeg, lineSeg, Descartes.LineSeg.initialPoint, Descartes.LineSeg.finalPoint, Descartes.LineSeg.length, draw) where

import Control.Exception (mask_)
import Data.Coerce (coerce)
import Descartes.Internal.Foreign.LineSeg (LineSeg_t, drawLineSeg, finalPoint, initialPoint, lineLength, lineSegDelete, lineSegNew)
import Descartes.Internal.Foreign.Point (pointDelete)
import Descartes.Internal.Point (Point (..))
import Foreign (ForeignPtr, newForeignPtr, withForeignPtr)
import Foreign.C.Types (CDouble (..))
import System.IO.Unsafe (unsafePerformIO)

newtype LineSeg = LineSeg (ForeignPtr LineSeg_t)

lineSeg :: Point -> Point -> LineSeg
lineSeg (Point frnP1) (Point frnP2) =
  LineSeg . unsafePerformIO . withForeignPtr frnP1 $
    \p1 -> withForeignPtr frnP2 $
      \p2 -> mask_ . newForeignPtr lineSegDelete $ lineSegNew p1 p2

initialPoint :: LineSeg -> Point
initialPoint (LineSeg frnLine) =
  Point . unsafePerformIO . withForeignPtr frnLine $
    \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.LineSeg.initialPoint ptr

finalPoint :: LineSeg -> Point
finalPoint (LineSeg frnLine) =
  Point . unsafePerformIO . withForeignPtr frnLine $
    \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.LineSeg.finalPoint ptr

length :: LineSeg -> Double
length (LineSeg frnLine) =
  unsafePerformIO . withForeignPtr frnLine $
    \ptr -> return . coerce . lineLength $ ptr

draw :: LineSeg -> IO ()
draw (LineSeg frnLine) =
  withForeignPtr frnLine drawLineSeg
