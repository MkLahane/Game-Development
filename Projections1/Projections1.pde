Cube cubes[];
void setup() {
  size(1500, 700);
  cubes = new Cube[50];
  float x = -180;
  float y = 70;
  float z = 10;
  int cols = 10;
  float spacing = 380 / 10;
  for (int i = 0; i < cubes.length; i++) {
    cubes[i] = new Cube(new PVector(x, y, z), spacing / 2);
    x += spacing;
    println("X="+x+", Y="+y);
    if (i + 1 >= cols && (i + 1) % cols == 0) {
      x = -180;
      y -= spacing;
    } 
  } 
  
} 


float getX(float x) {
  return map(x, -200, 200, 0, width);
} 
float getY(float y) {
  return map(y, -100, 100, height, 0);
} 
float getZ(float z) {
  return map(z, -100, 100, 0, 500);
} 
void draw() {
  background(255);
  for (Cube cube : cubes) {
    cube.show();
  } 
} 
