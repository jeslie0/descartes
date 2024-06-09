module Descartes.Rectangle (Rectangle, rectangle, Descartes.Rectangle.bottomLeft, Descartes.Rectangle.topRight, Descartes.Rectangle.fillRectangle, Descartes.Rectangle.clearRectangle) where

import Control.Exception (mask_)
import Descartes.Internal.Foreign.Rectangle (Rectangle_t, rectangleNew, rectangleDelete, bottomLeft, topRight, fillRectangle, clearRectangle)
import Descartes.Internal.Foreign.Point (pointDelete)
import Descartes.Internal.Point (Point (..))
import Foreign (ForeignPtr, newForeignPtr, withForeignPtr)
import System.IO.Unsafe (unsafePerformIO)

newtype Rectangle = Rectangle (ForeignPtr Rectangle_t)

rectangle :: Point -> Point -> Rectangle
rectangle (Point frnP1) (Point frnP2) =
  Rectangle . unsafePerformIO . withForeignPtr frnP1 $
  \p1 -> withForeignPtr frnP2 $
  \p2 -> mask_ . newForeignPtr rectangleDelete $ rectangleNew p1 p2

bottomLeft :: Rectangle -> Point
bottomLeft (Rectangle frnRect) =
  Point . unsafePerformIO . withForeignPtr frnRect $
  \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.Rectangle.bottomLeft ptr

topRight :: Rectangle -> Point
topRight (Rectangle frnRect) =
  Point . unsafePerformIO . withForeignPtr frnRect $
  \ptr -> mask_ . newForeignPtr pointDelete $ Descartes.Internal.Foreign.Rectangle.topRight ptr

fillRectangle :: Rectangle -> IO ()
fillRectangle (Rectangle frnRect) =
  withForeignPtr frnRect Descartes.Internal.Foreign.Rectangle.fillRectangle

clearRectangle :: Rectangle -> IO ()
clearRectangle (Rectangle frnRect) =
  withForeignPtr frnRect Descartes.Internal.Foreign.Rectangle.clearRectangle
