module Descartes
  ( Colour (..),
    setColour,
    clear,
    withGraphics,
    openGraphics,
    closeGraphics,
    Point,
    point,
    x,
    y,
    getPoint,
    LineSeg,
    lineSeg,
    initialPoint,
    finalPoint,
    Descartes.LineSeg.length,
    draw,
    Rectangle,
    rectangle,
    bottomLeft,
    topRight,
    fillRectangle,
    clearRectangle,
  )
where

import Descartes.LineSeg (LineSeg, draw, finalPoint, initialPoint, length, lineSeg)
import Descartes.Point (Point, getPoint, point, x, y)
import Descartes.Rectangle (Rectangle, bottomLeft, clearRectangle, fillRectangle, rectangle, topRight)
import Descartes.Window (Colour (..), clear, withGraphics ,closeGraphics, openGraphics, setColour)
