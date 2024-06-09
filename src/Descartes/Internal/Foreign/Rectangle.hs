{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
module Descartes.Internal.Foreign.Rectangle (Rectangle_t, rectangleNew, rectangleDelete, bottomLeft, topRight, fillRectangle, clearRectangle) where

import Foreign.Ptr ( FunPtr, Ptr )

import Descartes.Internal.Foreign.Point (Point_t)

data Rectangle_t

foreign import capi unsafe "rectangle_wrapper.h rectangle_new" rectangleNew :: Ptr Point_t -> Ptr Point_t -> Ptr Rectangle_t

foreign import capi unsafe "rectangle_wrapper.h &rectangle_delete" rectangleDelete :: FunPtr (Ptr Rectangle_t -> IO ())

foreign import capi unsafe "rectangle_wrapper.h bottom_left" bottomLeft :: Ptr Rectangle_t -> Ptr Point_t

foreign import capi unsafe "rectangle_wrapper.h top_right" topRight :: Ptr Rectangle_t -> Ptr Point_t

foreign import capi unsafe "rectangle_wrapper.h fill_rectangle" fillRectangle :: Ptr Rectangle_t -> IO ()

foreign import capi unsafe "rectangle_wrapper.h clear_rectangle" clearRectangle :: Ptr Rectangle_t -> IO ()
