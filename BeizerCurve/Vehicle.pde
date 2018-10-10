class Vehicle {
  PVector pos;
  PVector acc;
  PVector vel;
  
  ArrayList<PVector> trail=new ArrayList<PVector>();
  
  Vehicle(float x,float y) {
    pos=new PVector(x,y);
    acc=new PVector(0,0);
    vel=new PVector(0,0);
    
  } 
  
  void show() {
    fill(255);
    ellipse(pos.x,pos.y,20,20);
    /*for(PVector t:trail) {
      stroke(255);
      beginShape();
      vertex(t.x,t.y);
      endShape();
    } */
    
  } 
  
  void update() {
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
    acc.mult(0);
    
    trail.add(pos.get());
    if(trail.size()>100) {
      trail.remove(0);
    } 
    
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
    
  } 
  
  void seek(PVector target) {
    PVector desired=PVector.sub(target,pos);
    float d=desired.mag();
    if(d<100) {
      desired.mult(map(d,0,100,0,5));
    } else {
      desired.mult(5);
    } 
    PVector steer=PVector.sub(desired,vel);
    steer.limit(0.8);
    applyForce(steer);
    
  } 
  
} 