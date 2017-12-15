class Circle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float col;
  boolean collided=false;
  String group=null;
  Circle(PVector l,float _r) {
    r=_r;
    loc=l.get();
    vel=new PVector(random(-1,1),random(-1,1));
    acc=new PVector(0,0);
    col=0;
  } 
  void show() {
    fill(col);
    if(group!=null) {
       if(group=="first") {
         //fill(255,0,0);
       } else if(group=="second") {
         //fill(0,255,0);
       } else if(group=="third") {
         //fill(0,0,255);
       } else if(group=="fourth") {
         //fill(200,0,200);
       } 
    }
    stroke(255);
    strokeWeight(3);
    ellipse(loc.x,loc.y,r,r);
    
    
  } 
  
  void update() {
    loc.add(vel);
    vel.add(acc);
    acc.mult(0);
    vel.set(random(-1,1),random(-1,1));
  } 
  void applyForce(PVector f) {
    acc.add(f);
  } 
  boolean collided(Circle other) {
    if(PVector.dist(other.loc,loc)<r/2+other.r/2) {
      return true;
    } else {
      return false;
    }
  } 
}