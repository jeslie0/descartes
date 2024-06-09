{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
module Descartes.Internal.Foreign.LineSeg (LineSeg_t, lineSegNew, lineSegDelete, initialPoint, finalPoint, lineLength, drawLineSeg) where

import Foreign.Ptr ( FunPtr, Ptr )
import Foreign.C.Types ( CDouble(..) )

import Descartes.Internal.Foreign.Point

data LineSeg_t

foreign import capi unsafe "line_seg_wrapper.h line_seg_new" lineSegNew :: Ptr Point_t -> Ptr Point_t -> Ptr LineSeg_t

foreign import capi unsafe "line_seg_wrapper.h &line_seg_delete" lineSegDelete :: FunPtr (Ptr LineSeg_t -> IO ())

foreign import capi unsafe "line_seg_wrapper.h initial_point" initialPoint :: Ptr LineSeg_t -> Ptr Point_t

foreign import capi unsafe "line_seg_wrapper.h final_point" finalPoint :: Ptr LineSeg_t -> Ptr Point_t

foreign import capi unsafe "line_seg_wrapper.h length" lineLength :: Ptr LineSeg_t -> CDouble

foreign import capi unsafe "line_seg_wrapper.h draw_line_seg" drawLineSeg :: Ptr LineSeg_t -> IO ()
