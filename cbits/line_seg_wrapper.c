#include <stdlib.h>

#include "line_seg_wrapper.h"
#include "descartes/descartes.h"

lineSeg_t* line_seg_new(point_t* p1, point_t* p2)
{
    lineSeg_t* l = malloc(sizeof(lineSeg_t));
    *l = LineSeg(*p1, *p2);
    return l;
}

void line_seg_delete(lineSeg_t* l)
{
    free(l);
}

point_t* initial_point(lineSeg_t* l)
{
    point_t* p = malloc(sizeof(point_t));
    *p = InitialPoint(*l);
    return p;
}

point_t* final_point(lineSeg_t* l)
{
    point_t* p = malloc(sizeof(point_t));
    *p = FinalPoint(*l);
    return p;
}

double length(lineSeg_t* l)
{
    return Length(*l);
}

void draw_line_seg(lineSeg_t* l)
{
    DrawLineSeg(*l);
}
