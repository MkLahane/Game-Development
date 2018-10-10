PVector a;
PVector b;
void setup() {
  size(700, 700);
  a = PVector.fromAngle(-PI/4);
  b = PVector.fromAngle(0);
} 

void draw() {
  background(255);
  strokeWeight(4);
  drawVector(a, color(255, 0, 0));
  drawVector(b, color(0, 255, 0));
  PVector projectionOfAonB = b.get().normalize();
  projectionOfAonB.mult(a.dot(b));
  drawVector(projectionOfAonB, color(0, 0, 255));
  PVector perpendicular = PVector.sub(a, projectionOfAonB);
  drawVector(perpendicular, color(200, 0, 200));
} 

void drawVector(PVector vec,color col) {
  stroke(col);
  pushMatrix();
  translate(width / 2 - 150, height / 2);
  rotate(vec.heading());
  line(0, 0, vec.mag() * 300, 0);
  popMatrix();
} 