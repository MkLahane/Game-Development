class Vehicle {
  PVector loc;
  PVector acc;
  PVector vel;
  float r;
  float wandertheta;
  float maxspeed;
  float maxforce;
  
  Vehicle(float x,float y) {
    acc=new PVector(0,0);
    vel=new PVector(0,0);
    loc=new PVector(x,y);
    r=6;
    wandertheta=0;
    maxspeed=2;
    maxforce=0.05;
  } 
  void run() {
    update();
    borders();
    display();
    
  } 
  void display() {
    float angle=vel.heading()+PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(angle);
    beginShape(TRIANGLES);
    vertex(0,-r*2);
    vertex(-r,r*2);
    vertex(r,r*2);
    endShape();
    popMatrix();
    
  }
  void drawWanderStuff(PVector location, PVector circle, PVector target, float rad) {
  stroke(0); 
  noFill();
  ellipseMode(CENTER);
  ellipse(circle.x,circle.y,rad*2,rad*2);
  ellipse(target.x,target.y,4,4);
  line(location.x,location.y,circle.x,circle.y);
  line(circle.x,circle.y,target.x,target.y);
  }
  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    
  } 
  void wander() {
    float wanderR=25;
    float wanderD=80;
    float change=0.3;
    wandertheta+=random(-change,change);
    PVector circleloc=vel.get();
    circleloc.normalize();
    circleloc.mult(wanderD);
    circleloc.add(loc);
    float h=vel.heading2D();
    PVector nextpoint=new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target=PVector.add(circleloc,nextpoint);
    seek(target);
    drawWanderStuff(loc,circleloc,target,wanderR);
    
  } 
  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
    
  }
  void applyForce(PVector f) {
    acc.add(f);
    
  }
  void seek(PVector target) {
    PVector desired=PVector.sub(target,loc);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer=PVector.sub(desired,vel);
    steer.limit(maxforce);
    applyForce(steer);
    
    
  }
  
} 