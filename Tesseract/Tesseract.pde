


Vector[] points;
float angle = 0;

void setup() {
  size(700, 700, P3D);
  //teserract with 2cubes with all the points connected
  points = new Vector[16];
  
  points[0] = new Vector(-100, -100, -100, 100);
  points[1] = new Vector(100, -100, -100, 100);
  points[2] = new Vector(100, 100, -100, 100);
  points[3] = new Vector(-100, 100, -100, 100);
  points[4] = new Vector(-100, -100, 100, 100);
  points[5] = new Vector(100, -100, 100, 100);
  points[6] = new Vector(100, 100, 100, 100);
  points[7] = new Vector(-100, 100, 100, 100);
  
  points[8] = new Vector(-100, -100, -100, -100);
  points[9] = new Vector(100, -100, -100, -100);
  points[10] = new Vector(100, 100, -100, -100);
  points[11] = new Vector(-100, 100, -100, -100);
  points[12] = new Vector(-100, -100, 100, -100);
  points[13] = new Vector(100, -100, 100, -100);
  points[14] = new Vector(100, 100, 100, -100);
  points[15] = new Vector(-100, 100, 100, -100);
  
} 

void draw() {
  background(255);
  translate(width / 2, height / 2);
   
  rotateX(-PI / 2);
  stroke(0, 255, 0);
  strokeWeight(10);
  noFill();
  ArrayList<PVector> projectionVectors = new ArrayList<PVector>();
  Matrix projectionMatrix = new Matrix(4, 4);
  projectionMatrix = projectionMatrix.Identity();
  projectionMatrix.matrix[3][3] = 0;
  for (Vector vec : points) {
    vec.Normalize();
    Vector rotatedVec = RotateZW(vec, angle);
    rotatedVec = RotateXY(rotatedVec, angle);
    
    float viewDist = 1;
    float w = 1 / (viewDist - rotatedVec.w);
    projectionMatrix.matrix[0][0] = w;
    projectionMatrix.matrix[1][1] = w;
    projectionMatrix.matrix[2][2] = w;
    
    PVector projectedVector = matrixToVec(projectionMatrix.matrixMultiplication(vecToMatrix(rotatedVec)));
    
    projectedVector.mult(100);
    projectionVectors.add(projectedVector);
    point(projectedVector.x, projectedVector.y, projectedVector.z);
    
  } 
  
  //for (int i = 0; i < 4; i++) {
  //  connectTwoPoints(0, i, (i + 1) % 4, projectionVectors);
  //  connectTwoPoints(0, i + 4, ((i + 1) % 4) + 4, projectionVectors);
  //  connectTwoPoints(0, i, i + 4, projectionVectors); 
  //}
  //for (int i = 0; i < 4; i++) {
  //  connectTwoPoints(8, i, (i + 1) % 4, projectionVectors);
  //  connectTwoPoints(8, i + 4, ((i + 1) % 4) + 4, projectionVectors);
  //  connectTwoPoints(8, i, i + 4, projectionVectors); 
  //}
  //for (int i = 0; i < 8; i++) {
  //  connectTwoPoints(0, i, i + 8, projectionVectors);
  //} 
  for (int i = 0; i < points.length; i++) {
    for (int j = 1; j < points.length; j++) {
      float d = Dist(points[i], points[j]);
      if (d == 1) {
        connectTwoPoints(projectionVectors.get(i), projectionVectors.get(j));
      } 
    } 
  } 
  //angle = map(mouseX, 0, width, 0, TWO_PI);
  angle += 0.01;
  
}

void connectTwoPoints(PVector a, PVector b) {
  strokeWeight(2);
  stroke(0);
  line(a.x, a.y, a.z, b.x, b.y, b.z);
} 

void connectTwoPoints(int offset, int i, int j, ArrayList<PVector> projectedPoints) {
  PVector a = projectedPoints.get(i + offset);
  PVector b = projectedPoints.get(j + offset);
  strokeWeight(2);
  stroke(0);
  line(a.x, a.y, a.z, b.x, b.y, b.z);
  
} 
