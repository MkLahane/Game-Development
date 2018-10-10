Shape shape;
boolean colliding = false;
float getX(float x) {
  return map(x, -100, 100, 0, width);
} 
float getY(float y) {
  return map(y, 100, -100, 0, height);
} 
void setup() {
  size(600, 600);
  shape = new Shape(4);
  PVector point = new PVector(100, 100);
  float weightSum = 0;
  float[] weights = new float[4];
  printArray(shape.vertices);
  for (int i = 0; i < shape.vertices.length - 1; i++) {
    int prevIndex = (i + shape.vertices.length - 1) % shape.vertices.length;
    int next = (i+1) % shape.vertices.length;
    weights[i] = (cotangent(point,shape.vertices[i],shape.vertices[prevIndex]) + cotangent(point,shape.vertices[i],shape.vertices[next])) / PVector.sub(point, shape.vertices[i]).magSq();
    weightSum = weights[i];
  } 
  for (float weight : weights) {
    weight /= weightSum;
  } 
  printArray(weights);
  float sum = 0;
  for (int i = 0; i < weights.length; i++) {
    sum += weights[i];
  } 
  println(sum);
} 

float cotangent(PVector a, PVector b, PVector c) {
  PVector ba = PVector.sub(a, b);
  PVector bc = PVector.sub(c, b);
  bc.normalize();
  return bc.dot(ba);
} 

void draw() {
  background(255);
  if (colliding) {
    stroke(0, 255, 0);
  } else {
    stroke(0);
  } 
  strokeWeight(4);
  beginShape();
  noFill();
  for (PVector vertex : shape.vertices) {
    vertex(getX(vertex.x), getY(vertex.y));
  } 
  endShape(CLOSE);
  float x = map(mouseX, 0, width, -100, 100);
  float y = map(mouseY, height , 0, -100, 100);
  PVector point = new PVector(x, y);
  colliding = checkCollision(point);
  stroke(255, 0, 0);
  strokeWeight(12);
  point(getX(point.x), getY(point.y));
} 

boolean checkCollision(PVector point) {
  //PVector point = new PVector(100, 100);
  float weightSum = 0;
  float[] weights = new float[4];
  //printArray(shape.vertices);
  for (int i = 0; i < shape.vertices.length - 1; i++) {
    int prevIndex = (i + shape.vertices.length - 1) % shape.vertices.length;
    int next = (i+1) % shape.vertices.length;
    weights[i] = (cotangent(point,shape.vertices[i],shape.vertices[prevIndex]) + cotangent(point,shape.vertices[i],shape.vertices[next])) / PVector.sub(point, shape.vertices[i]).magSq();
    weightSum = weights[i];
  } 
  for (float weight : weights) {
    weight /= weightSum;
  } 
  //printArray(weights);
  float sum = 0;
  for (int i = 0; i < weights.length; i++) {
    sum += weights[i];
  } 
  for (int i = 0; i < weights.length; i++) {
    if (weights[i] < 0 || weights[i] > 1) {
      return false;
    } 
  } 
  return true;
  //println(sum);
} 

class Shape {
  PVector[] vertices;
  Shape(int _numOfVertices) {
    vertices = new PVector[_numOfVertices];
    for (int i = 0; i < vertices.length; i++) {
      float angle = map(i, 0, vertices.length, 0, TWO_PI);
      float x = round(cos(angle) * 10);
      float y = round(sin(angle) * 10);
      vertices[i] = new PVector(x, y);
    }
    //vertices[0] = new PVector(10, 0);
    //vertices[1] = new PVector(10, 10);
    //vertices[2] = new PVector(0, 10);
    //vertices[3] = new PVector(0, 0);
    
  } 
} 