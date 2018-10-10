ArrayList<Matrix> transformations;
ArrayList<Matrix> listOfConstants;
Matrix point;


void setup() {
  size(700, 700);
  colorMode(HSB, 255, 255, 255);
  transformations = new ArrayList<Matrix>();
  listOfConstants = new ArrayList<Matrix>();
  
  transformations.add(getMatrix(0.0, 0.0, 0.0, 0.16));
  listOfConstants.add(getMatrix(0.0, 0.0));
  
  transformations.add(getMatrix(0.85, 0.04, -0.04, 0.85));
  listOfConstants.add(getMatrix(0.0, 1.60));

  transformations.add(getMatrix(0.20, -0.26, 0.23, 0.22));
  listOfConstants.add(getMatrix(0.0, 1.60));

  transformations.add(getMatrix(-0.15, 0.28, 0.26, 0.24));
  listOfConstants.add(getMatrix(0.0, 0.44));


  point = new Matrix(2, 1);
  background(0);
} 

float getX(float x) {
  return map(x, -2.1820, 2.6558, 0, width);
  
} 

float getY(float y) {
  return map(y, 9.9983, 0, 0, height);
} 
Matrix getMatrix(float e, float f) {
  Matrix constants = new Matrix(2, 1);
  constants.matrix[0][0] = e;
  constants.matrix[1][0] = f;
  return constants;
} 

Matrix getMatrix(float a, float b, float c, float d) {
  Matrix transform = new Matrix(2, 2);

  transform.matrix[0][0] = a;
  transform.matrix[0][1] = b;

  transform.matrix[1][0] = c;
  transform.matrix[1][1] = d;


  return transform;
} 

int getIndex() {
  float r = random(1);
  if (r < 0.02) {
    return 0;
  } else if (r < 0.86) {
    return 1;
  } else if (r < 0.93) {
    return 2;
  } else {
    return 3;
  } 
} 

void nextPoint() {
  int rnIndex = getIndex();
  Matrix coefficients = transformations.get(rnIndex);
  Matrix constants = listOfConstants.get(rnIndex);
  point = coefficients.matrixMultiplication(point).addMatrix(constants);
  point.printTheMatrix();
} 

void drawPoint() {
  color col = color(map(point.matrix[1][0], 9.9983, 0, 255, 0), 255, 255, 255); 
  //stroke(0, 255, 0);
  noFill();
  stroke(col, 100);
  strokeWeight(map(point.matrix[1][0], 9.9983, 0, 4, 1));
  point(getX(point.matrix[0][0]), getY(point.matrix[1][0]));
} 

void draw() {

  for (int i = 0; i < 50; i++) {
    drawPoint();
    nextPoint();
  }
} 