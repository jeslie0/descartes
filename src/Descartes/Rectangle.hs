module Descartes.Rectangle (Rectangle, rectangle, Descartes.Rectangle.bottomLeft, Descartes.Rectangle.topRight, Descartes.Rectangle.fillRectangle, Descartes.Rectangle.clearRectangle) where

import Control.Exception (mask_)
import Descartes.Internal.Foreign.Rectangle (Rectangle_t, rectangleNew, rectangleDelete, bottomLeft, topRight, fillRectangle, clearRectangle)
import Descartes.Internal.Foreign.Point (pointDelete)
import Descartes.Internal.Point (Point (..))
import Foreign (ForeignPtr, newForeignPtr, withForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

-- | A rectangle is specified by its bottom left and top right
-- corners.
newtype Rectangle = Rectangle (ForeignPtr Rectangle_t)

instance Eq Rectangle where
  r1 == r2 =
    Descartes.Rectangle.bottomLeft r1 == Descartes.Rectangle.bottomLeft r2
    && Descartes.Rectangle.topRight r1 == Descartes.Rectangle.topRight r2

-- | A smart constructor for a rectangle. Takes the bottom left and
-- top right points, returning the rectangle.
rectangle :: Point -> Point -> Rectangle
rectangle (Point frnP1) (Point frnP2) =
  Rectangle . unsafePerformIO . withForeignPtr frnP1 $
  \p1 -> withForeignPtr frnP2 $
  \p2 -> mask_ . newForeignPtr rectangleDelete $ rectangleNew p1 p2

-- | Extract the bottom left corner as a point, from the rectangle.
bottomLeft :: Rectangle -> Point
bottomLeft (Rectangle frnRect) =
  Point . unsafePerformIO . withForeignPtr frnRect $
  \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.Rectangle.bottomLeft ptr

-- | Extract the top right corner as a point, from the rectangle.
topRight :: Rectangle -> Point
topRight (Rectangle frnRect) =
  Point . unsafePerformIO . withForeignPtr frnRect $
  \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.Rectangle.topRight ptr

-- | Render the rectangle on the active graphics window.
fillRectangle :: Rectangle -> IO ()
fillRectangle (Rectangle frnRect) =
  withForeignPtr frnRect Descartes.Internal.Foreign.Rectangle.fillRectangle

-- | Clear the specified rectangle from the active graphics window.
clearRectangle :: Rectangle -> IO ()
clearRectangle (Rectangle frnRect) =
  withForeignPtr frnRect Descartes.Internal.Foreign.Rectangle.clearRectangle
