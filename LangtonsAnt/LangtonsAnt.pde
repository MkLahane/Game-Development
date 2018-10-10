//Langton's ant 
int[][] grid;
int antX;
int antY;
int antDir;
int up=0;
int down=2;
int right=1;
int left=3;
PImage image;
void setup() {
  size(1200,700);
  //fullScreen();
  grid=new int[width][height];
  image=createImage(width,height,RGB);
  image.loadPixels();
  for(int i=0;i<image.pixels.length;i++) {
    image.pixels[i]=color(0);  
  } 
  image.updatePixels();
  antX=width/2;
  antY=height/2;
  antDir=up;
} 
void turnRight() {
  antDir++;
  if(antDir>left) {
    antDir=up;
  } 
} 

void turnLeft() {
  antDir--;
  if(antDir<up) {
    antDir=left;
  } 
} 

void moveForward() {
  switch(antDir) {
    case 0:
    {
      antY--;
      break;
    }
    case 1:{ 
      antX++; 
      break;
    }
    case 2: {
      antY++;
      break;
    } 
    case 3: {
      antX--;
      break;
    } 
  } 
  if(antX>width-1) {
    antX=0; 
  }else if(antX<0) {
    antX=width-1;
  } 
  if(antY>height-1) {
    antY=0; 
  }else if(antY<0) {
    antY=height-1;
  } 
} 

void draw() {
  background(255);
  image.loadPixels();
  for(int counter=0;counter<2000;counter++) {
    int state=grid[antX][antY];
    if(state==0) {
       turnRight();
       grid[antX][antY]=1;  
    }else if(state==1) {
      turnLeft();
      grid[antX][antY]=0;
    }
    color col=color(0);
    if(state==0) {
      col=color(0,255,0);
    } 
    int pixLoc=antX+antY*image.width;
    image.pixels[pixLoc]=col;
    moveForward();
  }
  image.updatePixels();
  image(image,0,0);
  //loadPixels();
  //for(int i=0;i<width;i++) {
  //  for(int j=0;j<height;j++) {
  //    int pixloc=i+width*j;
  //    if(grid[i][j]==0) {
  //      pixels[pixloc]=color(255);
  //    } else {
  //      pixels[pixloc]=color(0);
  //    } 
  //  } 
  //} 
  //updatePixels();
  //noLoop();
} 