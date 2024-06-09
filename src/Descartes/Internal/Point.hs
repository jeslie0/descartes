module Descartes.Internal.Point (Point(..)) where

import Descartes.Internal.Foreign.Point (Point_t)
import Foreign (ForeignPtr)

newtype Point = Point (ForeignPtr Point_t)
