{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
module Descartes.Internal.Foreign.Point (Point_t, pointNew, getPoint, pointDelete, pointXCoord, pointYCoord) where

import Foreign.Ptr ( FunPtr, Ptr )
import Foreign.C.Types ( CInt(..) )

data Point_t

foreign import capi unsafe "point_wrapper.h point_new" pointNew :: CInt -> CInt -> Ptr Point_t

foreign import capi unsafe "point_wrapper.h get_point" getPoint :: IO (Ptr Point_t)

foreign import capi unsafe "point_wrapper.h &point_delete" pointDelete :: FunPtr (Ptr Point_t -> IO ())

foreign import capi unsafe "point_wrapper.h x_coord" pointXCoord :: Ptr Point_t -> CInt

foreign import capi unsafe "point_wrapper.h y_coord" pointYCoord :: Ptr Point_t -> CInt
