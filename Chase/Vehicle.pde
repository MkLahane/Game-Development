class Vehicle {
  PVector loc;
  PVector acc;
  PVector vel;
  float maxspeed=4;
  float maxforce=0.6;
  float d=25;
  Vehicle(PVector l) {
    loc=l.get();
    acc=new PVector(0,0);
    vel=new PVector(0,0);
    
    
  } 
  void show() {
    fill(255);
    ellipse(loc.x,loc.y,20,20);
    
  } 
  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    
    
  } 
  
  void seek(PVector target) {
    float angle=PVector.angleBetween(loc,target);
    
    if(angle>radians(0) && angle<radians(45)) {
      PVector desired=PVector.sub(target,loc);
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer=PVector.sub(desired,vel);
      steer.limit(maxforce);
      applyForce(steer);
      
    } 
    else {
      applyForce(new PVector(0,0));
      
    } 
     
    
  } 
  void borders() {
    PVector desired=null;
    if(loc.x<d) {
      desired=new PVector(maxspeed,vel.y);
      
    } 
    else if(loc.x>width-d) {
      desired=new PVector(-maxspeed,vel.y);
      
      
    } 
    if(loc.y<d) {
      desired=new PVector(vel.y,maxspeed);
      
    }
    else if(loc.y>height-d) {
      desired=new PVector(vel.y,-maxspeed);
      
    }  
    if(desired!=null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer=PVector.sub(desired,vel);
      steer.limit(maxforce);
      applyForce(steer);
      
    } 
    
  } 
  void applyForce(PVector f) {
    acc.add(f);
    
    
  } 
  
  
} 