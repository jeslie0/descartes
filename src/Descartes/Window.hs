module Descartes.Window (Colour (..), Descartes.Window.setColour, clear, withGraphics, openGraphics, closeGraphics) where

import Control.Exception (bracket_)
import Descartes.Internal.Foreign.Window (clear, closeGraphics, openGraphics, setColour)

data Colour = White | Black | Red | Green | Blue deriving (Enum)

-- | Set the colour used to plot lines and rectangles.
setColour :: Colour -> IO ()
setColour =
  Descartes.Internal.Foreign.Window.setColour . fromIntegral . fromEnum
{-# INLINE setColour #-}

-- | Open a graphics window and run the given graphics commands. Close
-- the window when done.
withGraphics :: IO a -> IO a
withGraphics =
  bracket_ openGraphics closeGraphics
{-# INLINE withGraphics #-}
