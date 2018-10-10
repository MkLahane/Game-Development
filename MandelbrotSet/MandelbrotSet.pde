color[][] grid;
int resolution = 1;
float initialMin = -4.5;
float initialMax = 4.5;
int rows;
int cols; 
int maxIterations = 100;
void setup() {
  size(600, 600);

  rows = height / resolution;
  cols = width / resolution;
  grid = new color[rows][cols];
  configureMandelbrotSet();
}

void configureMandelbrotSet() {
    for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float a = map(i, 0, rows, initialMin, initialMax);
      float b = map(j, 0, cols, initialMin, initialMax);
      int n = 0;
      float ca = a;
      float cb = b;
      while (true) {
        float aa = a * a - b * b;
        float bb = 2 * b * a;
        a = ca + aa;
        b = cb + bb;
        if (a + b > 16) {
          break;
        } 
        n++;
        if (n >= 100) {
          break;
        }
      }
      float bright = map(n, 0, maxIterations, 0, 255);
      //bright = map(sqrt(bright), 0, 1, 0, 255);
      if (n == maxIterations) {
        bright = 0;
      } 
      grid[i][j] = color(bright, 0, bright, map(n, 0, 100, 255, 0));
    }
  }
} 

void draw() {
  background(0);


  //stroke(255);
  noStroke();
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      fill(grid[i][j]);
      rect(i * resolution, j * resolution, resolution, resolution);
    }
  }
  println(initialMin);
}


void keyPressed() {
  initialMin += 0.03;
  initialMax -= 0.001;
  configureMandelbrotSet();
} 
