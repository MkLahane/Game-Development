int imgHeight;
int imgWidth;
Cell[][] img;
Cell[][] originalImage;
PImage image;
boolean toggleScale = false;
float offset = 50;
PImage resizedImage;
void setup() {
  size(800, 800);
  image = loadImage("vp.jpg");
  image.resize(2048, 2048);
  imgHeight = image.height;
  imgWidth = image.width;
  image.loadPixels();
  float spacing = ((height - offset) - offset) / imgHeight;
  img = new Cell[imgHeight][imgWidth];
  for (int i = 0; i < imgHeight; i++) {
    for (int j = 0; j < imgWidth; j++) {
      int index = (j + i * imgWidth);
      img[i][j] = new Cell(i, j, image.pixels[index], spacing);
    }
  } 
  image.updatePixels();
  originalImage = img;
  println("Original image dimensions:"+imgHeight+" x "+imgWidth);
  println("Spacing:"+img[0][0].spacing);
  println();
  Resize(256, 256, "max");
  //ResizeF(4, 4, "max");
  resizedImage = createImage(img.length, img[0].length, RGB);
  resizedImage.loadPixels();
  for (int i = 0; i < img.length; i++) {
    for (int j = 0; j < img[0].length; j++) {
      int index = j + i * img[0].length;
      resizedImage.pixels[index] = img[i][j].gColor;
    }
  } 
  resizedImage.updatePixels();
  println(resizedImage.pixels.length);
  resizedImage.save("resizedSign.jpg");
  
} 

void colorImage() {
  float yOff = 0;
  for (int i = 0; i < imgHeight; i++) {
    float xOff = 0;
    for (int j = 0; j < imgWidth; j++) {
      int gCol = floor(map(noise(yOff, xOff), 0, 1, 0, 255));
      img[i][j].gColor = color(gCol, 0, (gCol / 2) % 255);
      //img[i][j].gColor = (int)random(0, 255);
      xOff += 0.09;
    } 
    yOff += 0.05;
  }
} 

void ResizeF(int filterSizeY, int filterSizeX, String typeOfPooling) {
  int newImgHeight = floor(imgHeight / filterSizeY);
  int newImgWidth = floor(imgWidth / filterSizeX);
  float newSpacingValue = img[0][0].spacing * filterSizeX;
  println("Filter size x:"+filterSizeX+" Filter size y:"+filterSizeY);
  println("New image dimensions:"+newImgHeight+" x "+newImgWidth);
  println("Spacing:"+newSpacingValue);
  println("Image size reduced by:"+ nf((1.0 * newImgHeight) / imgHeight * 100)+"%");
  img = new Cell[newImgHeight][newImgWidth];
  for (int i = 0; i < newImgHeight; i++) {
    for (int j = 0; j < newImgWidth; j++) {
      img[i][j] = new Cell(i, j, 0, newSpacingValue);
    }
  }
  for (int i = 0; i < (imgHeight - (filterSizeY - 1)); i+= filterSizeY) {
    for (int j = 0; j < (imgWidth - (filterSizeX - 1)); j+= filterSizeX) {
      float rSum = 0;
      float gSum = 0;
      float bSum = 0;
      float aSum = 0;
      if (typeOfPooling == "average") {
        for (int fi = i; fi < i + filterSizeY; fi++) {
          for (int fj = j; fj < j + filterSizeX; fj++) {
            color org_color = originalImage[i][j].gColor;
            rSum += red(org_color);
            gSum += green(org_color);
            bSum += blue(org_color);
            aSum += alpha(org_color);
          }
        }
        img[floor(i / filterSizeY)][floor(j / filterSizeX)].gColor = color(floor(rSum / (filterSizeX * filterSizeY)), floor(gSum / (filterSizeX * filterSizeY)), floor(bSum / (filterSizeX * filterSizeY)), floor(aSum / (filterSizeX * filterSizeY)));
      } else if (typeOfPooling == "max") {
        float maxR = -10000000;
        float maxG = -10000000;
        float maxB = -10000000;
        float maxA = -10000000;

        for (int fi = i; fi < i + filterSizeY; fi++) {
          for (int fj = j; fj < j + filterSizeX; fj++) {
            color org_color = originalImage[i][j].gColor;
            if (red(org_color) >= maxR) {
              maxR = red(org_color);
            } 
            if (green(org_color) >= maxG) {
              maxG = green(org_color);
            } 
            if (blue(org_color) >= maxB) {
              maxB = blue(org_color);
            } 
            if (alpha(org_color) >= maxA) {
              maxA = alpha(org_color);
            }
          }
        } 
        img[floor(i / filterSizeY)][floor(j / filterSizeX)].gColor = color(floor(maxR), floor(maxG), floor(maxB), floor(maxA));
      } else {
        println("Pooling type should be specified");
      }
    }
  }
} 



void Resize(int newImgHeight, int newImgWidth, String typeOfPooling) {
  int filterSizeY = ceil((imgHeight * 1.0) / newImgHeight);
  int filterSizeX = ceil((imgWidth * 1.0) / newImgWidth);
  float newSpacingValue = img[0][0].spacing * filterSizeX;
  println("Filter size x:"+filterSizeX+" Filter size y:"+filterSizeY);
  println("New image dimensions:"+newImgHeight+" x "+newImgWidth);
  println("Spacing:"+newSpacingValue);
  println("Image size reduced by:"+ nf((1.0 * newImgHeight) / imgHeight * 100)+"%");
  img = new Cell[newImgHeight][newImgWidth];
  for (int i = 0; i < newImgHeight; i++) {
    for (int j = 0; j < newImgWidth; j++) {
      img[i][j] = new Cell(i, j, 0, newSpacingValue);
    }
  }
  for (int i = 0; i < (imgHeight - (filterSizeY - 1)); i+= filterSizeY) {
    for (int j = 0; j < (imgWidth - (filterSizeX - 1)); j+= filterSizeX) {
      float rSum = 0;
      float gSum = 0;
      float bSum = 0;
      float aSum = 0;
      if (typeOfPooling == "average") {
        for (int fi = i; fi < i + filterSizeY; fi++) {
          for (int fj = j; fj < j + filterSizeX; fj++) {
            color org_color = originalImage[i][j].gColor;
            rSum += red(org_color);
            gSum += green(org_color);
            bSum += blue(org_color);
            aSum += alpha(org_color);
          }
        }
        img[floor(i / filterSizeY)][floor(j / filterSizeX)].gColor = color(round(rSum / (filterSizeX * filterSizeY)), round(gSum / (filterSizeX * filterSizeY)), round(bSum / (filterSizeX * filterSizeY)), round(aSum / (filterSizeX * filterSizeY)));
      } else if (typeOfPooling == "max") {
        float maxR = -10000000;
        float maxG = -10000000;
        float maxB = -10000000;
        float maxA = -10000000;

        for (int fi = i; fi < i + filterSizeY; fi++) {
          for (int fj = j; fj < j + filterSizeX; fj++) {
            color org_color = originalImage[i][j].gColor;
            if (red(org_color) >= maxR) {
              maxR = red(org_color);
            } 
            if (green(org_color) >= maxG) {
              maxG = green(org_color);
            } 
            if (blue(org_color) >= maxB) {
              maxB = blue(org_color);
            } 
            if (alpha(org_color) >= maxA) {
              maxA = alpha(org_color);
            }
          }
        } 
        img[int(i / filterSizeY)][int(j / filterSizeX)].gColor = color(round(maxR), round(maxG), round(maxB), round(maxA));
      }
    }
  }
} 





void draw() {
  background(0);
  noStroke();
  if (!toggleScale) {
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("Original:", 100, 40);
    //for (Cell[] row : originalImage) {
    //  for (Cell cell : row) {
    //    cell.show();
    //  }
    //}
    image(image, offset, offset, width - offset * 2, height - offset * 2);
  } else {
    //for (Cell[] row : img) {
    //  for (Cell cell : row) { 
    //    cell.show();
    //  }
    //}
    text("Resized:", 100, 40);
    image(resizedImage, offset, offset, width - offset * 2, height - offset * 2);
  }
  //image(image, 100, 100);
} 


void keyPressed() {
  if (key == ' ') {
    toggleScale = !toggleScale;
  }
} 
