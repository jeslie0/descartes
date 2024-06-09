#include "point_wrapper.h"
#include "descartes/descartes.h"
#include <stdlib.h>

point_t* point_new(int x, int y)
{
    point_t* p = malloc(sizeof(point_t));
    *p = Point(x, y);
    return p;
}

point_t* get_point(void)
{
    point_t* p = malloc(sizeof(point_t));
    *p = GetPoint();
    return p;
}

void point_delete(point_t* p)
{
    free(p);
}


int x_coord(point_t* p)
{
    return XCoord(*p);
}

int y_coord(point_t* p)
{

    return YCoord(*p);
}
