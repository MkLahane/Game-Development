class Vehicle {
  PVector loc;
  PVector acc;
  PVector vel;
  float r=5;
  float maxspeed;
  float maxforce;
  Vehicle(PVector l,float ms,float mf) {
    //loc=new PVector(random(width),random(height));
    loc=l.get();
    maxspeed=ms;
    maxforce=mf;
    acc=new PVector(0,0);
    vel=new PVector(0,0);
  } 
  void run() {
    //show();
    display();
    update();
    borders();
  } 
  
  void show() {
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
  
  void display() {
    stroke(0,175);
    ///strokeWeight(2);
    point(loc.x,loc.y);
  } 
  
  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
  } 
  
  void follow(Flow f) {
    PVector desired=f.lookUp(loc);
    desired.mult(maxspeed);
    PVector steer=PVector.sub(desired,vel);
    steer.limit(maxforce);
    applyForce(steer);
  } 
  
  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }
  
  
  
  
} 