class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  color col;
  float r = 10;
  
  Ball(PVector _pos, color _col) {
    col = getRandomColor();
    pos = _pos.get();
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
  } 
  void show() {
    noStroke();
    fill(col);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  } 
  
  void update() {
    vel.add(acc);
    vel.limit(8);
    pos.add(vel);
    acc.mult(0);
    pos.y = constrain(pos.y, 0, height - 50);
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
  } 
  
} 
