int[] imgRed;
int[] imgBlue;
int[] imgGreen;

int len = 60;
int resolution;
void setup() {
  size(600, 700);
  resolution = width / len;
  imgRed = new int[len];
  imgGreen = new int[len];
  imgBlue = new int[len];
  
  //red
  imgRed[0] = color(255, 0, 0);
  imgRed[len - 1] = color(255);
  //green
  imgGreen[0] = color(0, 255, 0);
  imgGreen[len - 1] = color(255);
  //blue
  imgBlue[0] = color(0, 0, 255);
  imgBlue[len - 1] = color(255);
  
  interpolate(imgRed, 0, len - 1);
  interpolate(imgGreen, 0, len - 1);
  interpolate(imgBlue, 0, len - 1);
} 

void interpolate(int[] img_arr, int startIndex, int endIndex) {
  for (int i = startIndex + 1; i < endIndex; i++) {
    float d = abs(startIndex - i);
    float totalD = abs(endIndex - startIndex);
    float percentageD = d / totalD;
    //println(leftP);
    color start = img_arr[startIndex];
    color end = img_arr[endIndex];
    img_arr[i] = interpolateColor(start, end, percentageD);
    //imgRed[i] = color(floor(percentageD * imgRed[endIndex] + (1 - percentageD) * imgRed[startIndex]));
    //println(imgRed[i]);
  } 
} 

color interpolateColor(color start, color end, float endPercentage) {
  float rS = red(start);
  float gS = green(start);
  float bS = blue(start);
  
  float rE = red(end);
  float gE = green(end);
  float bE = blue(end);
  float newR = rS * (1 - endPercentage) + endPercentage * rE;
  float newG = gS * (1 - endPercentage) + endPercentage * gE;
  float newB = bS * (1 - endPercentage) + endPercentage * bE;
  return color(newR, newG, newB);
} 

void draw() {
  background(51);
  noStroke();
  //red
  for (int i = 0; i < len; i++) {
    fill(imgRed[i]);
    rect(i * resolution, 150, resolution, resolution * 4);
  } 
  //green
  for (int i = 0; i < len; i++) {
    fill(imgGreen[i]);
    rect(i * resolution, 350, resolution, resolution * 4);
  } 
  //blue
  for (int i = 0; i < len; i++) {
    fill(imgBlue[i]);
    rect(i * resolution, 550, resolution, resolution * 4);
  } 
} 
