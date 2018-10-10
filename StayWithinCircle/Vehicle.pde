class Vehicle {
  PVector loc;
  PVector acc;
  PVector vel;
  float r=5;
  float maxspeed=3;
  float maxforce=0.1;
  
  Vehicle() {
    loc=new PVector(width/2,height/4);
    vel=new PVector(5,0);
    acc=new PVector(0,0);
    
  } 
  void show() {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  
  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
  } 
  
  void stayWithin() {
    PVector desired=null;
    PVector predict=vel.get();
    predict.normalize();
    predict.mult(75);
    
    PVector predictLoc=PVector.add(loc,predict);
    
    float dist=PVector.dist(circleLoc,predictLoc);
    if(dist>radiusOfCircle) {
      PVector pointToCenter=PVector.sub(circleLoc,predictLoc);
      pointToCenter.setMag(vel.mag());
      desired=PVector.add(vel,pointToCenter);
      desired.normalize();
      desired.mult(maxspeed);
    } 
    if(desired!=null) {
      PVector steer=PVector.sub(desired,vel);
      steer.limit(maxforce);
      applyForce(steer);
    } 
    fill(255,0,0);
    ellipse(predictLoc.x,predictLoc.y,4,4);
    
  } 
  
} 