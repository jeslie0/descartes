#ifndef LINE_SEG_WRAPPER_H
#define LINE_SEG_WRAPPER_H

#include "descartes/descartes.h"

// Create new dynamicall stored lineSeg_t struct.
lineSeg_t* line_seg_new(point_t* p1, point_t* p2);

// Clean up dynamically stored lineSeg_t.
void line_seg_delete(lineSeg_t* l);

// Return initial endpoint of lineSeg_t.
point_t* initial_point(lineSeg_t* l);

// Return final endpoint of lineSeg_t.
point_t* final_point(lineSeg_t* l);

// Return length of lineSeg_t.
double length(lineSeg_t* l);

// Draw the lineSeg_t in the window.
void draw_line_seg(lineSeg_t* l);

#endif
