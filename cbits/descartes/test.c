#include <stdlib.h>
#include <stdio.h>

#include "descartes.h"

int main(void) {
  OpenGraphics();

  point_t lastp = {-1,-1};
  int i=0;
  while ( i++ < 5 ) {
    point_t p;
    p = GetPoint();
    if ( p.x == -1 ) break;
    fprintf(stdout,"Point is (%d,%d)\n",p.x,p.y);
    if ( lastp.x != -1 ) {
      DrawLineSeg(LineSeg(lastp,p));
    }
    lastp = p;
  }
  Clear();
  int toggle = 1;
  while ( 1 ) {
    point_t p,q;
    p = GetPoint();
    q = GetPoint();
    rectangle_t r = Rectangle(p,q);
    if ( toggle ) { FillRectangle(r); } else { ClearRectangle(r); }
    toggle ^= 1;
  }
  CloseGraphics();
  return 0;
}
