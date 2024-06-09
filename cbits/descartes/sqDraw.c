
#include <stdlib.h>
#include <stdio.h>
#include "descartes.h"

/* Draws a square, of side 100, with given NW corner */

int main(void)
{
   point_t  p, q;    /*  Two points,        */
   lineSeg_t pq;     /*  a line segment     */
   int x, y;         /*  and two integers.  */
   OpenGraphics();

   printf("Indicate NW corner by clicking left mouse button.\n");
   p = GetPoint();   /* p stores the point where the user clicked. */
   x = XCoord(p);          /* We can take a point apart            */
   y = YCoord(p);          /* into its two coordinates...          */
   q = Point(x + 100, y);  /* and then reassemble.                 */
   pq = LineSeg(p, q);     /* Two points define a line segment.    */
   DrawLineSeg(pq);        /* Let's have a look at what we've got. */

   p = q;                  /* Start where we left off.*/
   x = XCoord(p);
   y = YCoord(p);
   q = Point(x, y - 100);
   pq = LineSeg(p, q);
   DrawLineSeg(pq);

   /* We can actually express these modifications more tersely.
    * We show the more terse way below, for the final two sides. */

   p = q;
   q = Point(XCoord(p) - 100, YCoord(p));
   DrawLineSeg(LineSeg(p, q));

   p = q;
   q = Point(XCoord(p), YCoord(p) + 100);
   DrawLineSeg(LineSeg(p, q));

   CloseGraphics();
   return EXIT_SUCCESS;
}
