//By nearest neighbor resampling
PImage Resize(color[][] givenGrid, int newRows, int newCols) {
  PImage resultingImage = createImage(newRows, newCols, RGB);
  resultingImage.loadPixels();
  float rowsRatio = (float)givenGrid.length / newRows;
  float colsRatio = (float)givenGrid[0].length / newCols;

  for (int i = 0; i < newRows; i++) {
    for (int j = 0; j < newCols; j++) {
      int orgI = floor(rowsRatio * i);
      int orgJ = floor(colsRatio * j);
      int index = j + i * newCols;
      resultingImage.pixels[index] = givenGrid[orgI][orgJ];
    }
  } 
  resultingImage.updatePixels();
  return resultingImage;
} 

PImage ResizeBiLinear(color[][] grid, int newRows, int newCols) {
  PImage resultingImage = createImage(newRows, newCols, RGB);
  resultingImage.loadPixels();
  for (int i = 0; i < newRows; i++) {
    for (int j = 0; j < newCols; j++) {
      float gx = (float) j / newCols * (grid[0].length - 1);
      float gy = (float) i / newRows * (grid.length - 1);
      int gj = (int) gx;
      int gi = (int) gy;
      float ichange = gy - gi;
      float jchange = gx - gj;
      color a = grid[gi][gj];
      color b = grid[gi][gj + 1];
      color c = grid[gi + 1][gj + 1];
      color d = grid[gi + 1][gj];
      
      int newR = getNewColor(red(a), red(b), red(c), red(d), ichange, jchange);
      int newG = getNewColor(green(a), green(b), green(c), green(d), ichange, jchange);
      int newB = getNewColor(blue(a), blue(b), blue(c), blue(d), ichange, jchange);
      int newA = getNewColor(alpha(a), alpha(b), alpha(c), alpha(d), ichange, jchange);
      int index = j + i * newCols;
      //println("Red = "+newR+", Green = "+newG+", Blue = "+newB+", Alpha = "+newA);
      resultingImage.pixels[index] = color(newR, newG, newB, newA);
    }
  } 
  resultingImage.updatePixels();
  return resultingImage;
} 


int getNewColor(float redA, float redB, float redC, float redD, float ichange, float jchange) {
  float sumR = 0;
  sumR += redA * (1 - ichange) * (1 - jchange);
  sumR += redB * (ichange) * (1 - jchange);
  sumR += redC * (1 - ichange) * (jchange);
  sumR += redD * (ichange) * (jchange);
  return floor(sumR);  
} 
