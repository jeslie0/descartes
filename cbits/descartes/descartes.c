#include <SDL/SDL.h>
#include <math.h>
#include <signal.h>
#include "descartes.h"

/* pull in the line drawing function from the SDL_draw code - don't want
   to compile and link separately */
#include "sdldraw-descartes.c"


static const int wsize = 500;

static const Uint32 colours[] = 
  { 0xffffffff, 0x0, 0x00ff0000, 0x0000ff00, 0x000000ff };

static Uint32 colour = 0;

static SDL_Surface *mySurface;

void SetColour(colour_t c) {
  colour = SDL_MapRGB(mySurface->format,
		      (colours[c] >> 16) & 0xFF,
		      (colours[c] >> 8) & 0xFF,
		      (colours[c]) & 0xFF);
}

static int Sqr(int n)
{
   return n*n;
}

point_t GetPoint(void)
{
   point_t p;
   

#ifdef FDESCARTES
   scanf("%d%d\n", &p.x, &p.y);
   return p;
#else
   SDL_Event ev;
   while ( SDL_WaitEvent(&ev) ) {
     if ( ev.type != SDL_MOUSEBUTTONDOWN ) continue;
     if ( ev.button.button == SDL_BUTTON_LEFT ) {
       p.x = ev.button.x;
       p.y = wsize - ev.button.y;
       break;
     } else if ( ev.button.button == SDL_BUTTON_MIDDLE ) {
       p.x = -1;
       p.y = -1;
       break;
     } else continue;
   }
   /* there doesn't seem to be a beep function in libsdl - this will
      work in a terminal, and we don't want to invoke the X function */
   fprintf(stderr,"\007");
   return p;
#endif
}

point_t Point(int a, int b)
{
   point_t p;

   p.x = a;
   p.y = b;
   return p;
}


int XCoord(point_t p)
{
   return p.x;
}


int YCoord(point_t p)
{
   return p.y;
}


lineSeg_t LineSeg(point_t p1, point_t p2)
{
   lineSeg_t l;
   
   l.initial = p1;
   l.final = p2;
   return l;
}


point_t InitialPoint(lineSeg_t l)
{
   return l.initial;
}


point_t FinalPoint(lineSeg_t l)
{
   return l.final;
}


double Length(lineSeg_t l)
{
   return sqrt(Sqr(XCoord(InitialPoint(l)) - XCoord(FinalPoint(l)))
             + Sqr(YCoord(InitialPoint(l)) - YCoord(FinalPoint(l))));
}


void DrawLineSeg(lineSeg_t l) 
{
  Draw_Line(mySurface,XCoord(InitialPoint(l)),
    wsize-1-YCoord(InitialPoint(l)),
    XCoord(FinalPoint(l)),
    wsize-1-YCoord(FinalPoint(l)),
    colour
	    );
  SDL_UpdateRect(mySurface,0,0,0,0);
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
  rectangle_t r = { bl, tr };
  return r;
}

point_t BottomLeft(rectangle_t r) {
  return r.bl;
}

point_t TopRight(rectangle_t r) {
  return r.tr;
}

void FillRectangle(rectangle_t rr) {
  Draw_FillRect(mySurface,XCoord(rr.bl),wsize-1-YCoord(rr.tr /* sic! */),
    XCoord(rr.tr)-XCoord(rr.bl)+1, YCoord(rr.tr)-YCoord(rr.bl)+1,colour);
  SDL_UpdateRect(mySurface,0,0,0,0);
}

void ClearRectangle(rectangle_t rr) {
  Draw_FillRect(mySurface,XCoord(rr.bl),wsize-1-YCoord(rr.tr /* sic! */),
    XCoord(rr.tr)-XCoord(rr.bl)+1, YCoord(rr.tr)-YCoord(rr.bl)+1,0xffffffff);
  SDL_UpdateRect(mySurface,0,0,0,0);
}

void Clear() {
  Draw_FillRect(mySurface,0,0,wsize-1,wsize-1,0xfffffff);
  SDL_UpdateRect(mySurface,0,0,0,0);
}

void OpenGraphics(void)
{
  SDL_Init(SDL_INIT_VIDEO);
  /* clear the handler for SIGINT */
  signal(SIGINT,SIG_DFL);
  mySurface = SDL_SetVideoMode(wsize,wsize,16,0);
  if ( mySurface == NULL ) {
    fprintf(stderr,"Video init failed: ");
    fprintf(stderr, "%s", SDL_GetError());
    fprintf(stderr,"\n");
    exit(1);
  }
  SDL_WM_SetCaption("Descartes","Descartes");
  SDL_Rect full = { 0, 0, wsize, wsize };
  if ( SDL_FillRect(mySurface, &full, 0xffffffff) < 0 ) {
    fprintf(stderr,"FillRect error!");
  }
  SDL_UpdateRect(mySurface,0,0,0,0);

}

void CloseGraphics(void)
{
   printf("Press right mouse button to close window!\007\n");
   SDL_Event ev;

   while ( SDL_WaitEvent(&ev) ) {
     if ( ev.type == SDL_MOUSEBUTTONDOWN 
       && ev.button.button == SDL_BUTTON_RIGHT ) {
       SDL_Quit();
     }
   }
}

