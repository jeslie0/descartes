#ifndef POINT_WRAPPER_H
#define POINT_WRAPPER_H

#include "descartes/descartes.h"

// Create new dynamically stored point_t struct.
point_t* point_new(int x, int y);

// Clean up dynamically stored point_t struct.
void point_delete(point_t* p);

// Wait until the user clicks the mouse, then return the point that
// the user is indicating.
point_t* get_point(void);

// Return the x-coordinate of the point.
int x_coord(point_t* p);

// Return the y-coordinate of the point.
int y_coord(point_t* p);

#endif
