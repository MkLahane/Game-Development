class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  float r;
  ArrayList<PVector> trail;
  Ball(PVector _pos, float _r) {
    r = _r;
    trail = new ArrayList<PVector>();
    pos = _pos.get();
    vel = PVector.fromAngle(random(0, -PI)).mult(random(6, 8));//new PVector(0, 0);
    acc = new PVector(0, 0);
  } 
  void show() {
    for (int i = 0; i < trail.size(); i++) {
      PVector trailPos = trail.get(i);
      float trailR = map(i, 0, trail.size(), r * 0.2, r);
      noStroke();
      fill(0, map(i, 0, trail.size(), 0, 200)); 
      ellipse(trailPos.x, trailPos.y, trailR * 2,  trailR * 2);
    } 
    stroke(100);
    strokeWeight(4);
    fill(0);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  } 
  String edges() {
    if (pos.x <= r) {
      pos.x = r;
      vel.x *= -1;
      return "left";
    } else if (pos.x >= width - r) {
      pos.x = width - r;
      vel.x *= -1;
      return "right";
    } 

    if (pos.y <= r) {
      pos.y = r;
      vel.y *= -1;
      return "up";
    }
    return "none";
  } 

  void update() {
    trail.add(pos.get());
    if (trail.size() >= 30) {
      trail.remove(0);
    } 
    vel.add(acc);
    vel.limit(6);
    pos.add(vel);
    acc.mult(0);
  } 
  void applyForce(PVector f) {
    acc.add(f);
  }
} 
