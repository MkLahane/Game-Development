float angle = 0;
int rows;
int cols;
int spacing = 80;

Curve[][] curves;

void setup() {
  //size(800, 800);
  fullScreen();
  rows = height / spacing - 1;
  cols = width / spacing  - 1;
  curves = new Curve[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      curves[i][j] = new Curve();
    } 
  } 
  
} 

void draw() {
  background(0);
  float[] xCoord = drawCircles('x', cols);
  float[] yCoord = drawCircles('y', rows);
  for (int i = 0; i < yCoord.length; i++) {
    for (int j = 0; j < xCoord.length; j++) {
      curves[i][j].addPoint(xCoord[j], yCoord[i]);
      curves[i][j].show();
    } 
  } 
  angle += 0.01;
  if (angle > TWO_PI) {
    angle = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        curves[i][j] = new Curve();
      } 
    } 
  } 
} 

float[] drawCircles(char axis, int len) {
  float[] coord = new float[len];
  float d = spacing - spacing * 0.2;
  for (int i = 0; i < len; i++) {
    float centerx = spacing / 2;
    float centery = spacing / 2;
    if (axis == 'x') {
      centerx = spacing + i * spacing + spacing / 2;
    } else if (axis == 'y') {
      centery = spacing + i * spacing + spacing / 2;
    }
    float x = cos((i + 1) * angle - PI / 2) * d / 2;
    float y = sin((i + 1) * angle - PI / 2) * d / 2;
    if (axis == 'x') {
      coord[i] = centerx + x;
    } else if (axis == 'y') {
      coord[i] = centery + y;
    } 
    stroke(100, map(i, 0, cols, 0, 255), 50);
    strokeWeight(2);
    ellipse(centerx, centery, d, d);
    strokeWeight(spacing * 0.09);
    point(centerx+x, centery+y);
    stroke(255, 60);
    strokeWeight(2);
    if (axis == 'x') {
      line(centerx + x, 0, centerx + x, height);
    } else if (axis == 'y') {
      line(0, centery + y, width, centery + y);
    } 
  } 
  return coord;
} 
