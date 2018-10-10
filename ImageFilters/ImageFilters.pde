
PImage img;
PImage filteredImg;

boolean toggle = false;
void setup() { 
  size(1400, 600);
  img = loadImage("portrait6.jpg"); // Load the original image
  filteredImg = createImage(img.width, img.height, RGB);
  //filteredImg = GaussianBlur(img);
  //filteredImg = DetectAllEdges(img);
  filteredImg = DetectEdge(img);
}



void draw() {
  background(0);
  //if (toggle) {
  image(filteredImg, width / 2, 0, width / 2, height); // Draw the new image
  //} else {
  image(img, 0, 0, width / 2, height); // Displays the image from point (0,0) 
  //}
}

void keyPressed() {
  if (key == ' ') {
    toggle = !toggle;
  }
} 
