
float[][] filterX = {{ -1, 0, 1}, 
  { -2, 0, 2}, 
  { -1, 0, 1}};

float[][] edgeFilter = {{-1, -1, -1}, 
  {-1, 8, -1}, 
  {-1, -1, -1}};

float[][] filterY = {{ -1, -2, -1}, 
  { 0, 0, 0}, 
  { 1, 2, 1}};

PImage Sharpen(PImage givenImage) {
  float[][] filter = {{0, -1, 0}, 
    {-1, 5, -1}, 
    {0, -1, 0}};
  ArrayList<float[][]> filters = new ArrayList<float[][]>();
  filters.add(filter);
  filters.add(filter);
  filters.add(filter);
  PImage result = createImage(givenImage.width, givenImage.height, 3);
  givenImage.loadPixels();
  for (int i = 1; i < givenImage.height - 1; i++) {
    for (int j = 1; j < givenImage.width - 1; j++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      for (int fi = -1; fi <= 1; fi++) {
        for (int fj = -1; fj <= 1; fj++) {
          int neighborPos = (fi + i) * givenImage.width + (fj + j);
          float valR = red(givenImage.pixels[neighborPos]);
          float valB = blue(givenImage.pixels[neighborPos]);
          float valG = green(givenImage.pixels[neighborPos]);
          //float val = (valR + valB + valG) / 3;

          sumR += valR * filters.get(0)[fi + 1][fj + 1];
          sumG += valG * filters.get(1)[fi + 1][fj + 1];
          sumB += valB * filters.get(2)[fi + 1][fj + 1];
        }
      }

      int edgeIndex = i * givenImage.width + j;
      result.pixels[edgeIndex] = color(sumR, sumG, sumB);
    }
  }
  result.updatePixels();
  return result;
}

PImage Emboss(PImage givenImage) {
  PImage result = createImage(givenImage.width, givenImage.height, RGB);
  float[][] filter = {{-2, -1, 0}, 
    {-1, 1, 1}, 
    {0, 1, 2}};

  ArrayList<float[][]> filters = new ArrayList<float[][]>();
  filters.add(filter);
  filters.add(filter);
  filters.add(filter);
  givenImage.loadPixels();
  for (int i = 1; i < givenImage.height - 1; i++) {
    for (int j = 1; j < givenImage.width - 1; j++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      for (int fi = -1; fi <= 1; fi++) {
        for (int fj = -1; fj <= 1; fj++) {
          int neighborPos = (fi + i) * givenImage.width + (fj + j);
          float valR = red(givenImage.pixels[neighborPos]);
          float valB = blue(givenImage.pixels[neighborPos]);
          float valG = green(givenImage.pixels[neighborPos]);
          //float val = (valR + valB + valG) / 3;

          sumR += valR * filters.get(0)[fi + 1][fj + 1];
          sumG += valG * filters.get(1)[fi + 1][fj + 1];
          sumB += valB * filters.get(2)[fi + 1][fj + 1];
        }
      }

      int edgeIndex = i * givenImage.width + j;
      result.pixels[edgeIndex] = color(sumR, sumG, sumB);
    }
  }
  result.updatePixels();
  return result;
} 



PImage GaussianBlur(PImage givenImage) {
  float[][][] filter = new float[3][3][3];
  for (int n = 0; n < 3; n++) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        filter[n][i][j] = 1.0 / 9.0;
      }
    }
  }
  PImage result = createImage(givenImage.width, givenImage.height, 3);
  givenImage.loadPixels();
  for (int i = 1; i < givenImage.height - 1; i++) {
    for (int j = 1; j < givenImage.width - 1; j++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      for (int fi = -1; fi <= 1; fi++) {
        for (int fj = -1; fj <= 1; fj++) {
          int neighborPos = (fi + i) * givenImage.width + (fj + j);
          float valR = red(givenImage.pixels[neighborPos]);
          float valB = blue(givenImage.pixels[neighborPos]);
          float valG = green(givenImage.pixels[neighborPos]);
          //float val = (valR + valB + valG) / 3;

          sumR += valR * filter[0][fi + 1][fj + 1];
          sumG += valG * filter[1][fi + 1][fj + 1];
          sumB += valB * filter[2][fi + 1][fj + 1];
        }
      }

      int edgeIndex = i * givenImage.width + j;
      result.pixels[edgeIndex] = color(sumR, sumG, sumB);
    }
  }
  result.updatePixels();
  return result;
} 

PImage DetectEdge(PImage givenImage) {
  PImage result = createImage(givenImage.width, givenImage.height, 3);
  givenImage.loadPixels();
  for (int i = 1; i < givenImage.height - 1; i++) {
    for (int j = 1; j < givenImage.width - 1; j++) {
      float sumX = 0;
      for (int fi = -1; fi <= 1; fi++) {
        for (int fj = -1; fj <= 1; fj++) {
          int neighborPos = (fi + i) * givenImage.width + (fj + j);
          float valR = red(givenImage.pixels[neighborPos]);
          float valB = blue(givenImage.pixels[neighborPos]);
          float valG = green(givenImage.pixels[neighborPos]);
          float val = (valR + valB + valG) / 3;
          sumX += val * filterX[fi + 1][fj + 1];
        }
      }
      float sumY = 0;
      for (int fi = -1; fi <= 1; fi++) {
        for (int fj = -1; fj <= 1; fj++) {
          int neighborPos = (fi + i) * givenImage.width + (fj + j);
          float valR = red(givenImage.pixels[neighborPos]);
          float valB = blue(givenImage.pixels[neighborPos]);
          float valG = green(givenImage.pixels[neighborPos]);
          float val = (valR + valB + valG) / 3;
          sumY += val * filterY[fi + 1][fj + 1];
        }
      }
      float sum = sqrt(sumX * sumX + sumY * sumY);
      int edgeIndex = i * givenImage.width + j;
      result.pixels[edgeIndex] = color(sum, sum, sum);
    }
  }
  result.updatePixels();
  return result;
}

PImage DetectAllEdges(PImage givenImage) {
  PImage result = createImage(givenImage.width, givenImage.height, 3);
  givenImage.loadPixels();
  for (int i = 1; i < givenImage.height - 1; i++) {
    for (int j = 1; j < givenImage.width - 1; j++) {
      float sum = 0;
      for (int fi = -1; fi <= 1; fi++) {
        for (int fj = -1; fj <= 1; fj++) {
          int neighborPos = (fi + i) * givenImage.width + (fj + j);
          float valR = red(givenImage.pixels[neighborPos]);
          float valB = blue(givenImage.pixels[neighborPos]);
          float valG = green(givenImage.pixels[neighborPos]);
          float val = (valR + valB + valG) / 3;
          sum += val * edgeFilter[fi + 1][fj + 1];
        }
      }
      //float sumY = 0;
      //for (int fi = -1; fi <= 1; fi++) {
      //  for (int fj = -1; fj <= 1; fj++) {
      //    int neighborPos = (fi + i) * givenImage.width + (fj + j);
      //    float valR = red(givenImage.pixels[neighborPos]);
      //    float valB = blue(givenImage.pixels[neighborPos]);
      //    float valG = green(givenImage.pixels[neighborPos]);
      //    float val = (valR + valB + valG) / 3;
      //    sumY += val * filterY[fi + 1][fj + 1];
      //  }
      //}
      int edgeIndex = i * givenImage.width + j;
      result.pixels[edgeIndex] = color(sum, sum, sum);
    }
  }
  result.updatePixels();
  return result;
}
