//sandPiles 
//if sand number in a cell > 4 then give each neighbor one sand particle
int[][] grid;
int rows; 
int cols;
int resolution = 3;
void setup() {
  size(1200, 800);
  rows = height / resolution;
  cols = width / resolution;
  grid = new int[rows][cols];
  grid[rows / 2][cols / 2] = 10000000;
} 

//void render() {
//  loadPixels();
//  for (int  i = 0; i < rows; i++) {
//    for (int j = 0; j < cols; j++) {
//      int num = grid[i][j];
//      color col = color(255, 255, 255);
//      if (num == 0) {
//        col = color(0, 0, 0);
//      } else if (num == 1) {
//        col = color(200, 0, 200);
//      } else if (num == 2) {
//        col = color(0, 200, 200);
//      } else if (num == 3) {
//        col = color(200, 200, 0);
//      } 
//      pixels[j + i * width] = col;
//    }
//  } 
//  updatePixels();
//} 
//toppling of sand;
void logic() {
  int[][] newGrid = new int[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int number = grid[i][j];
      if (number < 4) {
        newGrid[i][j] = number;
      }
    }
  }
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int number = grid[i][j];
      if (number >= 4) {
        newGrid[i][j] += number - 4;
        if (j > 0 && j < cols - 1 && i > 0 && i < rows - 1) {
          newGrid[i + 1][j]++;
          newGrid[i - 1][j]++;
          newGrid[i][j - 1]++;
          newGrid[i][j + 1]++;
        }
      }
    }
  }
  grid = newGrid;
} 

void mouseDragged() {
  grid[mouseY][mouseX] = 1000000;
} 

void draw() {
  for (int i = 0; i < 100; i++) {
    logic();
  }
  println(frameRate);
  Render();
} 

void Render() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int num = grid[i][j];
      color col = color(255, 255, 255);
      if (num == 0) {
        col = color(0, 0, 0);
      } else if (num == 1) {
        col = color(200, 0, 200);
      } else if (num == 2) {
        col = color(0, 200, 200);
      } else if (num == 3) {
        col = color(200, 200, 0);
      }
      fill(col);
      noStroke();
      rect(j * resolution, i * resolution, resolution, resolution);
    } 
  } 
} 