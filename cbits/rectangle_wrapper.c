#include <stdlib.h>

#include "rectangle_wrapper.h"
#include "descartes/descartes.h"

rectangle_t* rectangle_new(point_t* bl, point_t* tr)
{
    rectangle_t* r = malloc(sizeof(rectangle_t));
    *r = Rectangle(*bl, *tr);
    return r;
}

void rectangle_delete(rectangle_t* r)
{
    free(r);
}

point_t* bottom_left(rectangle_t* r)
{
    point_t* bl = malloc(sizeof(point_t));
    *bl = BottomLeft(*r);
    return bl;
}

point_t* top_right(rectangle_t* r)
{
    point_t* tr = malloc(sizeof(point_t));
    *tr = TopRight(*r);
    return tr;
}

void fill_rectangle(rectangle_t* r)
{
    FillRectangle(*r);
}

void clear_rectangle(rectangle_t* r)
{
    ClearRectangle(*r);
}
