class Particle {
  PVector pos;
  PVector vel;
  boolean inZone = false;
  Particle(PVector _pos) {
    pos = _pos.get();
    vel = PVector.random2D();
    vel.mult(4);
  } 
  void update() {
    pos.add(vel);
  } 
  void show() {
    if (inZone) {
      stroke(255, 0, 0);
    } else {
      stroke(255);
    }
    strokeWeight(12);
    point(pos.x, pos.y);
  } 
  void edge() {
    if(pos.y > height || pos.y < 0) {
      vel.y *= -1;
    } 
    if(pos.x > width || pos.x < 0) {
      vel.x *= -1;
    } 
  } 
} 