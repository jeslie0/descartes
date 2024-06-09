/* This is a dummy implementation of descartes which does nothing graphical,
   reads input from stdin or memory, and optionally prints tracing information to
   a filehandle. */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "tdescartes.h"
#include <errno.h>
#include <string.h>

/* program can set this variable, and then tracing information will
   be printed to it */
/* Alternatively the environment variable DESCARTES_TRACE can
   be set to a filename.
   Can also be set to - for stdout or -- for stderr.
*/
FILE *tracefile = NULL;
/* mask for things to be traced 
   Set from DESCARTES_TRACEMASK which shd be hex
 */

unsigned int tracemask = 0xFFFFFFFF;

static int nextpid = 1;
static int nextlid = 1;
static int nextrid = 1;

static int findTrace() {
  if ( tracefile == (FILE *)(-1) ) return 0;
  if ( tracefile ) return 1;
  char *fn;
  /* first set the mask */
  if ( (fn = getenv("DESCARTES_TRACEMASK")) ) {
    tracemask = (unsigned int)strtol(fn,NULL,0);
  }
  if ( (fn = getenv("DESCARTES_TRACE")) ) {
    if ( strcmp(fn,"-") == 0 ) {
      tracefile = stdout;
      return 1;
    } else if ( strcmp(fn,"--") == 0 ) {
      tracefile = stderr;
      return 1;
    } else {
      tracefile = fopen(fn,"w");
      if ( tracefile == NULL ) {
	fprintf(stderr,"tdescartes unable to open trace file %s: %s\n",
		fn,strerror(errno));
	tracefile = (FILE *)(-1);
	return 0;
      }
      return 1;
    }
  } else {
    tracefile = (FILE *)(-1);
  }
  return 0;
}

int Sqr(int n)
{
   return n*n;
}

/* by default, GetPoint reads integers from stdin .
   However, if getPoint_input is non-null, it will take
   input from the pointed to array, of length getPoint_inputlen. 
   Each time, it increments the pointer and decreases the length.
*/
int *getPoint_input = NULL;
int getPoint_inputlen = 0;


point_t GetPoint(void)
{
   point_t p;
   int n;
   
   if ( getPoint_input ) {
     if ( getPoint_inputlen % 2 || getPoint_inputlen < 0 ) {
       fprintf(stderr,"tdescartes: odd number of coords in input array\n");
       p.x = p.y = -1;
     } else if ( getPoint_inputlen == 0 ) {
       p.x = p.y = -1;
     } else {
       p.x = *getPoint_input++;
       p.y = *getPoint_input++;
       getPoint_inputlen -= 2;
     }
   } else {
     n = scanf("%d%d", &p.x, &p.y);
     if ( n != 2 ) { 
       if ( ! feof(stdin) ) {
	 fprintf(stderr,"tdescartes: format error on input\n");
       }
       p.x = p.y = -1; 
     }
   }
   p.id = nextpid++;
   if ( findTrace() && (tracemask & GETPOINT) )
     fprintf(tracefile,"GetPoint() < (%d,%d) = P%u\n",p.x,p.y,p.id);
   return p;
}

point_t Point(int a, int b)
{
   point_t p;

   p.x = a;
   p.y = b;
   p.id = nextpid++;
   if ( findTrace() && (tracemask & POINTS) )
     fprintf(tracefile,"Point(%d,%d) = P%u\n",a,b,p.id);
   return p;
}


int XCoord(point_t p)
{
  if ( findTrace() && (tracemask & POINTS) && (tracemask & ACCESSORS) ) 
    fprintf(tracefile,"XCoord(P%u) = %d\n",p.id,p.x);
  return p.x;
}


int YCoord(point_t p)
{
  if ( findTrace() && (tracemask & POINTS) && (tracemask & ACCESSORS) ) 
    fprintf(tracefile,"YCoord(P%u) = %d\n",p.id,p.y);
  return p.y;
}


lineSeg_t LineSeg(point_t p1, point_t p2)
{
   lineSeg_t l;
   
   l.initial = p1;
   l.final = p2;
   l.id = nextlid++;
   if ( findTrace() && (tracemask & LINESEGS) )
     fprintf(tracefile,"LineSeg(P%u,P%u) = L%u\n",p1.id,p2.id,l.id);
   return l;
}


point_t InitialPoint(lineSeg_t l)
{
  if ( findTrace() && (tracemask & LINESEGS) && (tracemask & ACCESSORS) )
    fprintf(tracefile,"InitialPoint(L%u) = P%u\n",l.id,l.initial.id);
  return l.initial;
}


point_t FinalPoint(lineSeg_t l)
{
  if ( findTrace() && (tracemask & LINESEGS) && (tracemask & ACCESSORS) )
    fprintf(tracefile,"FinalPoint(L%u) = P%u\n",l.id,l.final.id);
   return l.final;
}


double Length(lineSeg_t l)
{
  double len = sqrt(Sqr(XCoord(InitialPoint(l)) - XCoord(FinalPoint(l)))
             + Sqr(YCoord(InitialPoint(l)) - YCoord(FinalPoint(l))));
  if ( findTrace() && (tracemask & LENGTH) ) 
    fprintf(tracefile,"Length(L%u) = %f\n",l.id,len);
  return len;
}


void DrawLineSeg(lineSeg_t l) 
{
  if ( findTrace() && (tracemask & DRAWLINESEG) )
    fprintf(tracefile,"DrawLineSeg(L%u) = P%u->P%u = (%d,%d)->(%d,%d)\n",
      l.id,l.initial.id,l.final.id,l.initial.x,l.initial.y,l.final.x,l.final.y);
}

rectangle_t Rectangle(point_t bl, point_t tr) {
  if ( tr.x < bl.x ) {
    fprintf(stderr,"Rectangle: top-right corner left of bottom left! Setting equal.\n");
    tr.x = bl.x;
  }
  if ( tr.y < bl.y ) {
    fprintf(stderr,"Rectangle: top-right corner below bottom left! Setting equal.\n");
    tr.y = bl.y;
  }
  rectangle_t r = { bl, tr, nextrid++ };
  if ( findTrace() && (tracemask & RECTANGLES) ) {
    fprintf(tracefile,"Rectangle(R%u) = P%u-P%u = (%d,%d)-(%d,%d)\n",
      r.id,r.bl.id,r.tr.id,r.bl.x,r.bl.y,r.tr.x,r.tr.y);
  }
  return r;
}

point_t BottomLeft(rectangle_t r) {
  if ( findTrace() && (tracemask & ACCESSORS) && (tracemask & RECTANGLES) ) {
    fprintf(tracefile,"BottomLeft(R%u) = P%u = (%d,%d)\n",
      r.id,r.bl.id,r.bl.x,r.bl.y);
  }
  return r.bl;
}

point_t TopRight(rectangle_t r) {
  if ( findTrace() && (tracemask & ACCESSORS) && (tracemask & RECTANGLES) ) {
    fprintf(tracefile,"TopRight(R%u) = P%u = (%d,%d)\n",
      r.id,r.tr.id,r.tr.x,r.tr.y);
  }
  return r.tr;
}

void FillRectangle(rectangle_t r) {
  if ( findTrace() && (tracemask & RECTANGLES) ) {
    fprintf(tracefile,"FillRectangle(R%u) = P%u-P%u = (%d,%d)-(%d,%d)\n",
      r.id,r.bl.id,r.tr.id,r.bl.x,r.bl.y,r.tr.x,r.tr.y);
  }
}

void ClearRectangle(rectangle_t r) {
  if ( findTrace() && (tracemask & RECTANGLES) ) {
    fprintf(tracefile,"ClearRectangle(R%u) = P%u-P%u = (%d,%d)-(%d,%d)\n",
      r.id,r.bl.id,r.tr.id,r.bl.x,r.bl.y,r.tr.x,r.tr.y);
  }
}

void Clear() {
  if ( findTrace() && (tracemask & GRAPHICS) ) {
    fprintf(tracefile,"Clear()\n");
  }
}

void OpenGraphics(void)
{
  if ( findTrace() && (tracemask & GRAPHICS) )
    fprintf(tracefile,"OpenGraphics()\n");
}

void CloseGraphics(void)
{
  if ( findTrace() && (tracemask & GRAPHICS) )
    fprintf(tracefile,"CloseGraphics()\n");
  exit(0);
}

