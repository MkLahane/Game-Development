class Point {
  PVector pos;
  PVector acc;
  PVector vel;
  float r;
  Point (PVector _pos) {
    r = 20;
    pos = _pos.get();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  } 
  void show() {
    fill(0);
    stroke(100);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r * 2, r * 2);
    
    stroke(255);
    strokeWeight(10);
    point(pos.x, pos.y);
  } 
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  } 
  void applyForce(PVector f) {
    acc.add(f);
  }
} 
