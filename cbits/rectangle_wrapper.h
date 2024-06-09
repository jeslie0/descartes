#ifndef RECTANGLE_WRAPPER_H
#define RECTANGLE_WRAPPER_H

#include "descartes/descartes.h"

// Create new dynamically managed rectangle, from the bottom left and
// top right points.
rectangle_t* rectangle_new(point_t* bl, point_t* tr);

// Clean up dynamically managed rectangle.
void rectangle_delete(rectangle_t* r);

// Extract bottom left from rectangle.
point_t* bottom_left(rectangle_t* r);

// Extract top right point from rectangle.
point_t* top_right(rectangle_t* r);

// Plot rectangle on canvas, with colour that has been chosen.
void fill_rectangle(rectangle_t* r);

// Clear rectangle from canvas.
void clear_rectangle(rectangle_t* r);

#endif
