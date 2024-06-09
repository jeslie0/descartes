module Descartes.Window (Colour(..), Descartes.Window.setColour, clear, openGraphics, closeGraphics) where

import Descartes.Internal.Foreign.Window (setColour, clear, openGraphics, closeGraphics)

data Colour = White | Black | Red | Green | Blue deriving Enum

setColour :: Colour -> IO ()
setColour =
  Descartes.Internal.Foreign.Window.setColour . fromIntegral . fromEnum
