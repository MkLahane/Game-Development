class Bullet {
  PVector pos;
  PVector acc;
  PVector vel;
  float r = 10;
  Bullet(PVector _pos, PVector _acc, PVector _vel) {
    vel = _vel.get();
    acc = _acc.get();
    pos = _pos.get();
  } 
  void show() {
    fill(0);
    stroke(80);
    strokeWeight(6);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  } 
  void update() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  } 
  
} 
