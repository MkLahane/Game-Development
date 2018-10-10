//minkowski difference for collision detection
PVector[] triangleA;
PVector[] square;
void setup() {
  size(600, 600);
  square = new PVector[4];
  triangleA = new PVector[3];
  square[0] = new PVector(0, 0);
  square[1] = new PVector(2, 0);
  square[2] = new PVector(2, 2);
  square[3] = new PVector(1, 2);
  
  triangleA[0] = new PVector(-2, 0);
  triangleA[1] = new PVector(0, 0);
  triangleA[2] = new PVector(-1, 2);
  
  
  
}

boolean checkCollision() {
  PVector[] newSet = new PVector[triangleA.length * square.length];
  int counter = 0;
  for (int j = 0; j < triangleA.length; j++) {
    for (int i = 0; i < square.length; i++) {
      newSet[counter] = PVector.sub(triangleA[j], square[i]);
      counter++;
    } 
  } 
  for (PVector vec : newSet) {
    if (vec.x == 0 && vec.y == 0) {
      return true;
    }
  } 
  return false;
  //drawShape(newSet);
} 

float getX(float x) {
  return map(x, -10, 10, 0, width);
} 

float getY(float y) {
  return map(y, -10, 10, height, 0);
} 

void drawShape(PVector[] shape) {
  beginShape();
  for (PVector v : shape) {
    vertex(getX(v.x), getY(v.y));
  } 
  endShape(CLOSE);
} 

void draw() {
  background(255);
  if (checkCollision()) {
    stroke(255, 0, 0);
  } else {
    stroke(0);
  }
  noFill();
  strokeWeight(3);
  drawShape(triangleA);
  drawShape(square);
  stroke(0, 255, 0);
  
} 

void keyPressed() {
  float dir = 0;
  if (key == 'a') {
    dir = -0.5;
  } else {
    dir = 0.5;
  } 
  square[0].x += dir;
} 