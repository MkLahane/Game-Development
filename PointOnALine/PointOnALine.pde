PVector a;
PVector b;
float u;
float v;
void setup() {
  size(700, 700);
  a = new PVector(width / 2 - 200, height / 2);
  b = new PVector(width / 2 + 200, height / 2 - 100);
  u = random(1);
  v = 1 - u;
} 

void draw() {
  background(0);
  println("("+u+", "+v+")");
  v = 1 - u;
  //to keep the point in line 
  if (v + u != 1 || v < 0) {
    noLoop();
  } 
  strokeWeight(4);
  stroke(255);
  line(a.x, a.y, b.x, b.y);
  PVector A = a.get();
  PVector B = b.get();
  PVector p = A.mult(u).add(B.mult(v));
  stroke(255, 0, 0);
  strokeWeight(12);
  point(p.x, p.y);
} 

void mouseDragged() {
  u = map(mouseX, width, 0, 0, 1);
} 

void keyPressed() {
  if(key == ' ') {
    u = 1;
  } else {
    u = 0;
  } 
  // Barycentric co - ordinates are defined for point as (u, v) 
  // are the baycentric co - ordinates of point p with respect 
  // to A and B 
  // Baycentric co - ordinates of A = (1, 0) and B = (0, 1).
  
} 