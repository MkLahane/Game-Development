


PVector[] points;
float angle = 0;

void setup() {
  size(700, 700);
  points = new PVector[8];
  
  points[0] = new PVector(-100, -100, -100);
  points[1] = new PVector(100, -100, -100);
  points[2] = new PVector(100, 100, -100);
  points[3] = new PVector(-100, 100, -100);
  points[4] = new PVector(-100, -100, 100);
  points[5] = new PVector(100, -100, 100);
  points[6] = new PVector(100, 100, 100);
  points[7] = new PVector(-100, 100, 100);
  
} 

void draw() {
  background(255);
  translate(width / 2, height / 2);
 
  //beginShape();
  ArrayList<PVector> projectedPoints = new ArrayList<PVector>();
  
  for (PVector vec : points) {
    vec.normalize();
    //PVector Tvec = RotateX(vec, angle);
    PVector Tvec = RotateY(vec, angle);
    //Tvec = RotateZ(Tvec, angle);
    
    float viewDistance = 1;
    float z = 1 / (viewDistance - Tvec.z);
    Matrix projectionMatrix = makeProjectionMatrix(z);
    PVector projectedVec = matrixToVec(projectionMatrix.matrixMultiplication(vecToMatrix(Tvec)));
    projectedVec.mult(200);
    projectedPoints.add(projectedVec);
  } 
  stroke(0, 255, 0);
  strokeWeight(10);
  noFill();
  for (PVector vec : projectedPoints) {
    point(vec.x, vec.y);
  } 
  for (int i = 0; i < 4; i++) {
    connectTwoPoints(i, (i + 1) % 4, projectedPoints);
    connectTwoPoints(i + 4, ((i + 1) % 4) + 4, projectedPoints);
    connectTwoPoints(i, i + 4, projectedPoints); 
  }
  //endShape(CLOSE);
  angle += 0.01;
  
}

void connectTwoPoints(int i, int j, ArrayList<PVector> projectedPoints) {
  PVector a = projectedPoints.get(i);
  PVector b = projectedPoints.get(j);
  strokeWeight(2);
  stroke(0);
  line(a.x, a.y, b.x, b.y);
  
} 

PVector RotateZ(PVector vec, float angle) {
  Matrix rotationMatrix = new Matrix(3, 3);
  rotationMatrix.matrix[0][0] = cos(angle);
  rotationMatrix.matrix[1][0] = sin(angle);
  rotationMatrix.matrix[2][0] = 0;
  
  
  rotationMatrix.matrix[0][1] = -sin(angle);
  rotationMatrix.matrix[1][1] = cos(angle);
  rotationMatrix.matrix[2][1] = 0;
  
  rotationMatrix.matrix[0][2] = 0;
  rotationMatrix.matrix[1][2] = 0;
  rotationMatrix.matrix[2][2] = 1;
 
  return matrixToVec(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

} 

PVector RotateX(PVector vec, float angle) {
  Matrix rotationMatrix = new Matrix(3, 3);
  rotationMatrix.matrix[0][0] = 1;
  rotationMatrix.matrix[1][0] = 0;
  rotationMatrix.matrix[2][0] = 0;
  
  
  rotationMatrix.matrix[0][1] = 0;
  rotationMatrix.matrix[1][1] = cos(angle);
  rotationMatrix.matrix[2][1] = sin(angle);
  
  rotationMatrix.matrix[0][2] = 0;
  rotationMatrix.matrix[1][2] = -sin(angle);
  rotationMatrix.matrix[2][2] = cos(angle);
 
  return matrixToVec(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

} 

PVector RotateY(PVector vec, float angle) {
  Matrix rotationMatrix = new Matrix(3, 3);
  rotationMatrix.matrix[0][0] = cos(angle);
  rotationMatrix.matrix[1][0] = 0;
  rotationMatrix.matrix[2][0] = sin(angle);
  
  
  rotationMatrix.matrix[0][1] = 0;
  rotationMatrix.matrix[1][1] = 1;
  rotationMatrix.matrix[2][1] = 0;
  
  rotationMatrix.matrix[0][2] = -sin(angle);
  rotationMatrix.matrix[1][2] = 0;
  rotationMatrix.matrix[2][2] = cos(angle);
 
  return matrixToVec(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

} 


 //matrix for projecting a 3d object in 2d
Matrix makeProjectionMatrix(float depth) {
  Matrix projectionMatrix = new Matrix(3, 3);
  projectionMatrix.matrix[0][0] = depth;
  projectionMatrix.matrix[0][1] = 0;
  projectionMatrix.matrix[0][2] = 0;
  projectionMatrix.matrix[1][0] = 0;
  projectionMatrix.matrix[1][1] = depth;
  projectionMatrix.matrix[1][2] = 0;
  
  projectionMatrix.matrix[2][0] = 0;
  projectionMatrix.matrix[2][1] = 0;
  projectionMatrix.matrix[2][2] = 0;
  return projectionMatrix;
} 
