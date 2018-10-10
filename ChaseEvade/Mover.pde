class Mover {
  PVector loc;
  PVector vel;
  PVector acc;
  float r=5;
  PVector mouse=new PVector (mouseX,mouseY);
  int definer;
  float maxspeed=4,maxforce=0.9;
  Mover(PVector l,int value) {
    loc=l.copy();
    definer=value;
    acc=new PVector(0,0);
    vel=new PVector(0,0);
    
  } 
  void show() {
    float angle=vel.heading()+PI/2;
    fill(255,175);
    stroke(0);
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(angle);
    beginShape();
    vertex(0,-r*2);
    vertex(-r,r*2);
    vertex(r,r*2);
    endShape(CLOSE);
    popMatrix();
    
  } 
  void update( ) {
    vel.add(acc);
   
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    
  }
  void applyForce(PVector f) {
    acc.add(f);
    
  } 
  PVector ChaseorEvade(Mover m) {
    PVector desired=PVector.sub(m.loc,loc);
    float d=desired.mag();
    desired.normalize();
    if(d<100) {
      desired.mult(map(d,0,100,0,maxspeed));
     
    } 
    else {
      desired.mult(maxspeed);
      
    } 
    PVector steer=PVector.sub(desired,vel);
    steer.limit(maxforce);
    steer.mult(definer);
    
    return steer;
    
  } 
  PVector border() {
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
      return steer;
      
    } 
    else {
      return new PVector(0,0);
    } 
    
  } 
  
} 