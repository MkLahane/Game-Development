PImage givenImage;
PImage resizedImage;
boolean toggleScale = false;


void setup() {
  size(700, 700);
  givenImage = loadImage("resizedImage.jpg");
  //givenImage.resize(512, 256);
  resizedImage = ResizeBiLinear(gridByImage(givenImage), 4096, 4096);
  resizedImage.save("enlargedImageBilinear.jpg");
  println("Original Image: "+givenImage.height+" x "+givenImage.width);
  println("Resized Image: "+resizedImage.height+" x "+resizedImage.width);
  
} 



void draw() {
  background(0);
  textAlign(CENTER);
  if (toggleScale) {
    fill(255);
    textSize(40);
    text("Resized:", 100, 40);
    image(resizedImage, 100, 100, 500, 500);
  } else {
    textSize(40);
    text("Original:", 100, 40);    
    image(givenImage, 100, 100, 500, 500);
  }
} 

void keyPressed() {
  if (key == ' ') {
    toggleScale = !toggleScale;
  }
} 




color[][] gridByImage(PImage img) {
  int rows = img.height;
  int cols = img.width;
  img.loadPixels();
  color[][] grid = new color[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int index = j + i * cols;
      grid[i][j] = img.pixels[index];
    }
  }
  return grid;
} 
