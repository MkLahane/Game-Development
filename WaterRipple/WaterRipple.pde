//with int you get very different result

float[][] currentWater;
float[][] previousWater;
int cols;
int rows;
PImage img;
void setup() {
  size(800, 700);
  rows = height;
  cols= width;
  currentWater = new float[cols][rows];
  previousWater = new float[cols][rows];
  img = loadImage("dog4.jpg");
  img.resize(width, height);
} 
void mouseDragged() {
  if (mouseX >= 0 && mouseX < width && mouseY >=0 && mouseY < height) {
    currentWater[mouseX][mouseY] = 255;
  }
} 

void draw() {
  background(0);
  //image(img, 0, 0);
  loadPixels();
  for(int i = 1; i < cols - 1; i++) {
    for(int j = 1; j < rows - 1; j++) {
      currentWater[i][j] = (
        previousWater[i - 1][j] +
        previousWater[i + 1][j] +
        previousWater[i][j + 1] +
        previousWater[i][j - 1]) / 2 - currentWater[i][j];
      currentWater[i][j] *= 0.94;
      int index = i + j * cols;
      //float r = 0;
      //float g = 0;
      //float b = currentWater[i][j] * 255;
      //pixels[index] = color(r, g, b);
      color c = img.get(i, j);
      float r = red(c);
      float g = green(c); 
      float b = blue(c);
      float alpha = alpha(c) * currentWater[i][j] * 255;
     
      pixels[index] = color(r, g, b, alpha);
      //pixels[index] = color(255 * currentWater[i][j]);
      //float r = red(img.pixels[index]);
      //float g = green(img.pixels[index]);
      //float b = blue(img.pixels[index]);
      
      ////r *= currentWater[i][j];
      ////g *= currentWater[i][j];
      ////b *= currentWater[i][j];
      //float a = currentWater[i][j] * alpha(img.pixels[index]);
      
      //img.pixels[index] = color(r, g, b);
      
      ////pixels[index] = color(img.get(i, j) * currentWater[i][j]);
    } 
  }
  updatePixels();
  float[][] temp = previousWater;
  previousWater = currentWater;
  currentWater = temp;
} 