class Particle {
  PVector loc;
  PVector gravity=new PVector(0,0.1);
  PVector vel;
  Particle(PVector _loc) {
    loc=_loc.copy();
    vel=new PVector(2,1.3);
    vel.mult(3);
    
    
  } 
  void show() {
    fill(0,0,255);
    ellipse(loc.x,loc.y,20,20);
  } 
  
  void update() {
    loc.add(vel);
    vel.add(gravity);
  } 
  void checkEdges() {
    if(loc.x>width || loc.x<0) {
      vel.x*=-1;
    } 
    if(loc.y>height) {
      vel.y*=-1;
      loc.y=height;
      vel.mult(0.99);
    } 
    
  } 
  
  
} 