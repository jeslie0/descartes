#ifndef DESCARTES_H
#define DESCARTES_H

/*
 * A point is specified by its x- and y-coordinates.
 */
typedef struct {int x, y;} point_t;


/*
 * A line segment is specified by its start and end points.
 */
typedef struct {point_t initial, final;} lineSeg_t;

/*
 * A rectangle is specified by its bottom-left and top-right corners.
 */
typedef struct {point_t bl, tr;} rectangle_t;

/*
 * Waits until the user clicks the mouse, 
 * then returns the point that the user is indicating.
*/
point_t GetPoint(void);


/*
 * Creates a point with given coordinates.
 */
point_t Point(int x, int y);


/*
 * Returns the x-coordinate of the point given as argument.
 */
int XCoord(point_t p);


/*
 * Returns the y-coordinate of the point given as argument.
 */
int YCoord(point_t p);


/*
 * Creates a line segment with given endpoints.
 */
lineSeg_t LineSeg(point_t p1, point_t p2);


/* 
 * Returns one endpoint of a line segment...
 */
point_t InitialPoint(lineSeg_t l);


/* 
 * ... returns the other endpoint.
 */
point_t FinalPoint(lineSeg_t l);


/* 
 * Returns the length of a line segment.
 */
double Length(lineSeg_t l);

/* 
 * Available colours
 */

typedef enum { White, Black, Red, Green, Blue } colour_t;

/* 
 * Sets the drawing colour 
 */
void SetColour(colour_t c);

/*
 * Draws a line segment.
 */
void DrawLineSeg(lineSeg_t l);

/*
 * Creates a rectangle with the given bottom left and top right.
 */
rectangle_t Rectangle(point_t bl, point_t tr);

/*
 * Extract the bottom left of a rectangle.
 */
point_t BottomLeft(rectangle_t r);

/*
 * Extract the top right of a rectangle.
 */
point_t TopRight(rectangle_t r);

/*
 * Fills a rectangle.
 */
void FillRectangle(rectangle_t r);

/*
 * Clears a rectangle.
 */
void ClearRectangle(rectangle_t r);

/*
 * Clears the entire window
 */
void Clear();

/*
 * Opens and initialises the graphics window
 */
void OpenGraphics(void);

/*
 * Closes the graphics window
 */
void CloseGraphics(void);


#endif
