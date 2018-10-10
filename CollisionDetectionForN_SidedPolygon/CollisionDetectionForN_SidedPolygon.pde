ArrayList<Shape> shapes;

Vehicle vehicle;
float getX(float x) {
  return map(x, -100, 100, 0, width);
}
float getY(float y) {
  return map(y, -100, 100, height, 0);
} 
boolean colliding = false;
void setup() {
  size(700, 700);
  shapes = new ArrayList<Shape>();
  for (int i = 0; i < 7; i++) {
    Shape shape = new Shape(8);
    shapes.add(shape);
  }
  vehicle = new Vehicle(0);
  //println(vehicle.a);
  //println(vehicle.b);
  //println(vehicle.c);
} 

PVector getVectorInCartesian(PVector vec) {
  float x = map(vec.x, 0, width, -100, 100);
  float y = map(vec.y, height , 0, -100, 100);
  return new PVector(x, y);
} 

void draw() {
  background(255);
  vehicle.show();
  vehicle.update();
  vehicle.seek(new PVector(mouseX, mouseY));
  //for (Triangle triangle : triangles) {
  //  triangle.show();
  //} 
  for (Shape shape : shapes) {
    shape.show();
  } 
  println(frameRate);
  float x = map(mouseX, 0, width, -100, 100);
  float y = map(mouseY, 0, height, 100, -100);
  PVector p = new PVector(x, y);
  strokeWeight(12);
  stroke(0, 255, 0);
  point(getX(p.x), getY(p.y));
  for (Shape shape : shapes) {
     PVector a = getVectorInCartesian(vehicle.a);
     PVector b = getVectorInCartesian(vehicle.b);
     PVector c = getVectorInCartesian(vehicle.c);
     PVector pos = getVectorInCartesian(vehicle.pos);
     shape.colliding = shape.update(a) || shape.update(b) || shape.update(c) || shape.update(pos);
     
  } 
  
} 