{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE ForeignFunctionInterface #-}

module Descartes.Internal.Foreign.Window where

import Foreign.C.Types (CInt (..))

foreign import capi unsafe "descartes/descartes.h SetColour" setColour :: CInt -> IO ()

foreign import capi unsafe "descartes/descartes.h Clear" clear :: IO ()

foreign import capi unsafe "descartes/descartes.h OpenGraphics" openGraphics :: IO ()

foreign import capi unsafe "descartes/descartes.h CloseGraphics" closeGraphics :: IO ()
