class Vehicle {
  PVector pos;
  PVector vel;
  PVector acc;
  float viewRadius;
  float viewAngle;
  float maxspeed=3;
  float r=10;
  
  Vehicle(PVector _pos) {
    pos=_pos.get();
    vel=PVector.random2D();
    vel.mult(3);
    acc=new PVector(0,0);
    viewRadius=100;
    viewAngle=radians(90);
  } 
  
  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    pos.add(vel);
    acc.mult(0);
   
  } 
  
  void show() {
    float theta = vel.heading2D() + radians(90);
    //viewAngle=viewAngle+theta;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
    
    PVector angleA=PVector.fromAngle(-viewAngle/2);
    PVector angleB=PVector.fromAngle(viewAngle/2);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(vel.heading()+angleA.heading());
    stroke(255);
    line(0,0,100,0);
    popMatrix();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(vel.heading()+angleB.heading());
    stroke(255);
    line(0,0,100,0);
    popMatrix();
    
    pushMatrix();
    translate(pos.x,pos.y);
    stroke(255);
    noFill();
    ellipse(0,0,viewRadius*2,viewRadius*2);
    popMatrix();
    
  } 
  
  void whoIsVisible(Object o) {
    PVector dirToTarget=PVector.sub(o.pos,pos).normalize();
    float angleBetVec=PVector.angleBetween(vel,dirToTarget);
    if(angleBetVec<viewAngle/2) {
        float d=PVector.dist(pos,o.pos);
        if(d<viewRadius) {
          println("I can see");
          o.isVisible=true;
        } 
    } 
  }
  
  void seek(PVector target) {
    PVector desired=PVector.sub(target,pos);
    desired.setMag(3);
    PVector steer=PVector.sub(desired,vel);
    steer.limit(0.5);
    applyForce(steer);
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
  } 
  
  void edges() {
    PVector desired=null;
    if(pos.x>width) {
      desired=new PVector(-maxspeed,vel.y);
    } else if(pos.x<0)  {
      desired=new PVector(maxspeed,vel.y);
    } 
    
    if(pos.y>height) {
      desired=new PVector(vel.x,-maxspeed);
    } else if(pos.y<0) {
      desired=new PVector(vel.x,maxspeed);
    } 
    if(desired!=null) {
      desired.mult(maxspeed);
      PVector steer=PVector.sub(desired,vel);
      steer.limit(0.1);
      applyForce(steer);
    } 
    
  } 
  
} 