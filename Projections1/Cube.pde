class Cube {
  PVector center;
  float size;
  PVector[] vertices;
  PVector[] projectionVertices2D;
  Matrix projectionMatrix;
  float angle = 0;
  float angleRate;
  Cube(PVector _center, float _size) {
    size = _size;
    angleRate = random(0.008, 0.03);
    vertices = new PVector[8];
    center = _center.get();
    projectionMatrix = new Matrix(3, 3);
    projectionMatrix = projectionMatrix.Identity();
    projectionMatrix.matrix[2][2] = 0;

    vertices[0] = new PVector(center.x - size, center.y + size, center.z + size);
    vertices[1] = new PVector(center.x + size, center.y + size, center.z + size);
    vertices[2] = new PVector(center.x + size, center.y - size, center.z + size);
    vertices[3] = new PVector(center.x - size, center.y - size, center.z + size);
    vertices[4] = new PVector(center.x - size, center.y + size, center.z - size);
    vertices[5] = new PVector(center.x + size, center.y + size, center.z - size);
    vertices[6] = new PVector(center.x + size, center.y - size, center.z - size);
    vertices[7] = new PVector(center.x - size, center.y - size, center.z - size);
    projectionVertices2D = new PVector[8];
  } 
  Matrix getRotationX() {
    Matrix rotationMatrix = new Matrix(3, 3);
    rotationMatrix = rotationMatrix.Identity();
    rotationMatrix.matrix[1][1] = cos(angle);
    rotationMatrix.matrix[2][1] = sin(angle);
    rotationMatrix.matrix[1][2] = -sin(angle);
    rotationMatrix.matrix[2][2] = cos(angle);
    return rotationMatrix;
  }
  Matrix getRotationY() {
    Matrix rotationMatrix = new Matrix(3, 3);
    rotationMatrix = rotationMatrix.Identity();
    rotationMatrix.matrix[0][0] = cos(angle);
    rotationMatrix.matrix[2][0] = sin(angle);
    rotationMatrix.matrix[0][2] = -sin(angle);
    rotationMatrix.matrix[2][2] = cos(angle);
    return rotationMatrix;
  }
  Matrix getRotationZ() {
    Matrix rotationMatrix = new Matrix(3, 3);
    rotationMatrix = rotationMatrix.Identity();
    rotationMatrix.matrix[0][0] = cos(angle);
    rotationMatrix.matrix[1][0] = sin(angle);
    rotationMatrix.matrix[0][1] = -sin(angle);
    rotationMatrix.matrix[1][1] = cos(angle);
    return rotationMatrix;
  }
  void show() {
    noStroke();
    Matrix rotationMatrixY = getRotationY();
    Matrix rotationMatrixX = getRotationX();
    Matrix rotationMatrixZ = getRotationZ();
    Matrix rotationMatrix = rotationMatrixY.matrixMultiplication(rotationMatrixX);
    rotationMatrix = rotationMatrix.matrixMultiplication(rotationMatrixZ);
    for (int i = 0; i < projectionVertices2D.length; i++) {
      PVector copyVertex = PVector.sub(center, vertices[i].get());
      copyVertex.normalize();
      PVector projectedVertex = matrixToVec(projectionMatrix.matrixMultiplication(rotationMatrix.matrixMultiplication(vecToMatrix(copyVertex))));
      projectedVertex.mult(size);
      projectedVertex.add(center);
      projectionVertices2D[i] = projectedVertex;
    }

    stroke(0, 255, 0);
    strokeWeight(12);
    for (PVector vertex : projectionVertices2D) {
      point(getX(vertex.x), getY(vertex.y));
    } 
    for (int i = 0; i < 4; i++) {
      drawLine(projectionVertices2D[i], projectionVertices2D[(i + 1) % 4]);
      drawLine(projectionVertices2D[i + 4], projectionVertices2D[((i + 1) % 4) + 4]);
      drawLine(projectionVertices2D[i], projectionVertices2D[i + 4]);
    }
    angle += angleRate;
  } 
  void drawLine(PVector a, PVector b) {
    stroke(0);
    strokeWeight(2);
    line(getX(a.x), getY(a.y), getX(b.x), getY(b.y));
  }
} 


Matrix vecToMatrix(PVector vec) {
  Matrix m1 = new Matrix(3, 1);
  m1.matrix[0][0] = vec.x;
  m1.matrix[1][0] = vec.y;
  m1.matrix[2][0] = vec.z;
  return m1;
} 

PVector matrixToVec(Matrix m1) {
  PVector v = new PVector(0, 0);
  v.x = m1.matrix[0][0];
  v.y = m1.matrix[1][0];
  if (m1.rows > 2) {
    v.z = m1.matrix[2][0];
  } 
  return v;
} 
