class Vehicle {
  PVector loc;
  PVector acc;
  PVector vel;

  Vehicle(PVector l) {
    loc=l.get();
    acc=new PVector(0,0);
    vel=new PVector(0,0);
    
  } 
  void show() {
    fill(255);
    translate(loc.x,loc.y,loc.z);
    rotate(vel.heading2D()+PI/2);
    box(50);
    
    
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
  } 
  void update() {
    vel.add(acc);
    vel.limit(5);
    loc.add(vel);
    acc.mult(0);
    
  } 
  void seek(PVector target) {
    PVector desired=PVector.sub(target,loc);
    desired.setMag(5);
    PVector steer=PVector.sub(desired,vel);
    steer.limit(0.5);
    
    applyForce(steer);
  } 
  
} 