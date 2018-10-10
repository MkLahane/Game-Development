import java.util.*;
Matrix scalingMatrix;
Matrix rotationMatrix;
Matrix currentTransformationMatrix = null;
Stack<Matrix> historyOfTransformations;
int undoLength = 8;
PVector a;
PVector b; 
PVector c; 


float getX(float x) {
  return map(x, -1000, 1000, 0, width);
} 
float getY(float y) {
  return map(y, -1000, 1000, height, 0);
} 
void setup() {
  size(700, 700);
  a = new PVector(0, 100);
  b = new  PVector(-100, 0);
  c = new PVector(100, 0);
  historyOfTransformations = new Stack<Matrix>();
  scalingMatrix = new Matrix(2, 2);
  rotationMatrix = new Matrix(2, 2);
  float angle = PI / 4;
  rotationMatrix.matrix[0][0] = sin(angle);
  rotationMatrix.matrix[1][0] = cos(angle);
  
  rotationMatrix.matrix[0][1] = -sin(angle);
  rotationMatrix.matrix[1][1] = cos(angle);
  
  scalingMatrix.matrix[0][0] = 1;
  scalingMatrix.matrix[1][0] = 0;
  
  scalingMatrix.matrix[0][1] = 0;
  scalingMatrix.matrix[1][1] = 2;
  
  
} 

void draw() {
  background(0);
  strokeWeight(4);
  stroke(255);
  line(getX(a.x), getY(a.y), getX(b.x), getY(b.y));
  line(getX(a.x), getY(a.y), getX(c.x), getY(c.y));
  line(getX(b.x), getY(b.y), getX(c.x), getY(c.y));
  if (historyOfTransformations.size() > undoLength) {
    historyOfTransformations.remove(0);
  } 
} 

void keyPressed() {
  Matrix triangle = new Matrix(3, 2);
  triangle.matrix[0][0] = a.x;
  triangle.matrix[0][1] = a.y;
  
  triangle.matrix[1][0] = b.x;
  triangle.matrix[1][1] = b.y;
  
  triangle.matrix[2][0] = c.x;
  triangle.matrix[2][1] = c.y;
  
  if (key == 's') {
    triangle = triangle.matrixMultiplication(scalingMatrix);
    historyOfTransformations.add(scalingMatrix);
  }
  if (key == 'r') {
    triangle = triangle.matrixMultiplication(rotationMatrix);
    historyOfTransformations.add(rotationMatrix);
  } 
  if (key == 'z') {
    if (!historyOfTransformations.isEmpty()) {
      Matrix currentTransformationMatrix = historyOfTransformations.pop();
      Matrix undoTransformationMatrix = currentTransformationMatrix.Inverse(currentTransformationMatrix);
      triangle = triangle.matrixMultiplication(undoTransformationMatrix);
    } 
    
  } 
  
  a.x = triangle.matrix[0][0];
  a.y = triangle.matrix[0][1];
  
  b.x = triangle.matrix[1][0];
  b.y = triangle.matrix[1][1];
  
  c.x = triangle.matrix[2][0];
  c.y = triangle.matrix[2][1];
  
} 