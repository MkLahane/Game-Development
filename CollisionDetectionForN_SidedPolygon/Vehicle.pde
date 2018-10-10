class Vehicle {
  PVector pos;
  PVector a;
  PVector b;
  PVector c;
  float angle;
  float r = 40;
  PVector acc;
  PVector vel;
  Vehicle(float _angle) {
    angle = _angle;
    pos = new PVector(width / 2, height / 2);
    float aX = pos.x + cos(angle) * r;
    float aY = pos.y + sin(angle) * r;
    a = new PVector(aX, aY);
    float bX = pos.x + cos(angle - radians(120)) * r;
    float bY = pos.y + sin(angle - radians(120)) * r;
    b = new PVector(bX, bY);
    float cX = pos.x + cos(angle + radians(120)) * r;
    float cY = pos.y + sin(angle + radians(120)) * r;
    c = new PVector(cX, cY);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
  } 
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    angle = vel.heading();
    float aX = pos.x + cos(angle) * r;
    float aY = pos.y + sin(angle) * r;
    a = new PVector(aX, aY);
    float bX = pos.x + cos(angle - radians(120)) * r;
    float bY = pos.y + sin(angle - radians(120)) * r;
    b = new PVector(bX, bY);
    float cX = pos.x + cos(angle + radians(120)) * r;
    float cY = pos.y + sin(angle + radians(120)) * r;
    c = new PVector(cX, cY);
    
  }
  void show() {
    stroke(0);
    strokeWeight(4);
    beginShape();
    vertex(a.x, a.y);
    vertex(b.x, b.y);
    vertex(c.x, c.y);
    //vertex(getX(a.x), getY(a.y));
    //vertex(getX(b.x), getY(b.y));
    //vertex(getX(c.x), getY(c.y));
    endShape(CLOSE);
  } 
  void applyForce(PVector f) {
    acc.add(f);
  } 
  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    float d = desired.mag();
    desired.normalize();
    if (d < 100) {
      desired.mult(map(d, 0, 100, 0, 10));
    } else {
      desired.mult(10);
    } 
    //angle = desired.heading();
    PVector steer = PVector.sub(desired, vel);
    steer.limit(0.5);
    applyForce(steer);
  } 
} 