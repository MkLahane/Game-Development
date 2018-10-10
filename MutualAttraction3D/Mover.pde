class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  Mover(PVector _pos,float _mass) {
    mass=_mass;
    pos=_pos.get();
    vel=new PVector(1,0,0);
    acc=new PVector(0,0,0);
  } 
  void show() {
    stroke(255);
    noFill();
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(mass*2);
    popMatrix();
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