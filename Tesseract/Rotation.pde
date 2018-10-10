//PVector RotateZ(PVector vec, float angle) {
//  Matrix rotationMatrix = new Matrix(3, 3);
//  rotationMatrix.matrix[0][0] = cos(angle);
//  rotationMatrix.matrix[1][0] = sin(angle);
//  rotationMatrix.matrix[2][0] = 0;
  
  
//  rotationMatrix.matrix[0][1] = -sin(angle);
//  rotationMatrix.matrix[1][1] = cos(angle);
//  rotationMatrix.matrix[2][1] = 0;
  
//  rotationMatrix.matrix[0][2] = 0;
//  rotationMatrix.matrix[1][2] = 0;
//  rotationMatrix.matrix[2][2] = 1;
 
//  return matrixToVec(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

//} 

Vector RotateXY(Vector vec, float angle) {
  Matrix rotationMatrix = new Matrix(4, 4);
  rotationMatrix = rotationMatrix.Identity();
  rotationMatrix.matrix[0][0] = cos(angle);
  rotationMatrix.matrix[0][1] = -sin(angle);
  
  rotationMatrix.matrix[1][0] = sin(angle);
  rotationMatrix.matrix[1][1] = cos(angle);
  
  
  return matrixToVec4(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

} 
Vector RotateXZ(Vector vec, float angle) {
  Matrix rotationMatrix = new Matrix(4, 4);
  rotationMatrix = rotationMatrix.Identity();
  rotationMatrix.matrix[0][0] = cos(angle);
  rotationMatrix.matrix[2][0] = sin(angle);
  
  rotationMatrix.matrix[0][2] = -sin(angle);
  rotationMatrix.matrix[2][2] = cos(angle);
  
  
  return matrixToVec4(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

} 
Vector RotateXW(Vector vec, float angle) {
  Matrix rotationMatrix = new Matrix(4, 4);
  rotationMatrix = rotationMatrix.Identity();
  rotationMatrix.matrix[0][0] = cos(angle);
  rotationMatrix.matrix[3][0] = sin(angle);
  
  rotationMatrix.matrix[0][3] = -sin(angle);
  rotationMatrix.matrix[3][3] = cos(angle);
  
  
  return matrixToVec4(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

}

Vector RotateZW(Vector vec, float angle) {
  Matrix rotationMatrix = new Matrix(4, 4);
  rotationMatrix = rotationMatrix.Identity();
  rotationMatrix.matrix[2][2] = cos(angle);
  rotationMatrix.matrix[3][2] = sin(angle);
  
  rotationMatrix.matrix[2][3] = -sin(angle);
  rotationMatrix.matrix[3][3] = cos(angle);
  
  
  return matrixToVec4(rotationMatrix.matrixMultiplication(vecToMatrix(vec)));

}
