class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass = 1;
  float dampingCoeff = 0.08;
  Particle(PVector _pos) {
    pos = _pos.get();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  } 
  void show() {
    fill(0, 150);
    noStroke();
    ellipse(pos.x, pos.y, 20, 20);
  }
  
  void update() {
    float t = 1;
    PVector dampingForce = vel.get().mult(-dampingCoeff);
    applyForce(dampingForce);
    vel.add(acc.get().mult(t));
    pos.add(vel.get().mult(t));
    vel.mult(0.98);
    acc.mult(0);
  } 
  void applyForce(PVector f) {
    PVector force = f.get();
    force.div(mass);
    acc.add(force);
  }
} 
