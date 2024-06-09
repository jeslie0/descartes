{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE ForeignFunctionInterface #-}

module Descartes.Internal.Foreign.Window where

import Foreign.C.Types (CInt (..))

foreign import capi unsafe "descartes/descartes.h SetColour" setColour :: CInt -> IO ()

-- | Clear all data from graphics window.
foreign import capi unsafe "descartes/descartes.h Clear" clear :: IO ()

-- | Open the graphics window. It is 500px by 500px with (0, 0) at the
--  bottom left and (500, 500) at the top right.
foreign import capi unsafe "descartes/descartes.h OpenGraphics" openGraphics :: IO ()

-- | Close the graphics window.
foreign import capi unsafe "descartes/descartes.h CloseGraphics" closeGraphics :: IO ()
