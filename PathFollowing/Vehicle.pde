class Vehicle {
  PVector loc;
  PVector acc;
  PVector vel;
  float r;
  float maxspeed;
  float maxforce;
  Vehicle(PVector l,float ms,float mf) {
    r=4;
    loc=l.copy();
    maxforce=mf;
    maxspeed=ms;
    acc=new PVector(0,0);
    vel=new PVector(maxspeed,0);
    
  } 
  
  void separate(ArrayList<Vehicle> boids) {
    PVector sum=new PVector(0,0);
    int count=0;
    float d=r*4;
    for(Vehicle v:boids) {
      float dist=PVector.dist(loc,v.loc);
      if(dist<d && dist>0) {
        PVector diff=PVector.sub(loc,v.loc);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
        
      } 
      
    } 
    if(count>0) {
      sum.div(float(count));
      if(sum.mag()>0) {
        sum.normalize();
        sum.mult(maxspeed);
        PVector steer=PVector.sub(sum,vel);
        steer.limit(maxforce);
        applyForce(steer);
      }
    } 
    
  } 
  void border() {
    if(loc.x>width) {
      loc.x=0;
      loc.y=height/3;
    } 
    
    
  } 
  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
    
  } 
  void display() {
    fill(0);
    ellipse(loc.x,loc.y,r*2,r*2);
    
  }
  void show() {
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
  void seek(PVector t) {
    PVector desired=PVector.sub(t,loc);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer=PVector.sub(desired,vel);
    steer.limit(maxforce);
    applyForce(steer);
    
  } 
  void Follow(Path p) {
    PVector a=p.start;
    PVector b=p.end;
    PVector predict=vel.get();
    predict.normalize();
    //25 frames ahead
    predict.mult(25);
    PVector predictLoc=PVector.add(loc,predict);
    PVector normal=getNormalPoint(predictLoc,a,b);
    PVector diff=PVector.sub(b,a);
    diff.normalize();
    diff.mult(10);
    PVector target=PVector.add(normal,diff);
    float d=PVector.dist(normal,predictLoc);
    if(d>p.r) {
      seek(target);
    } 
    
    
  } 
  PVector getNormalPoint(PVector p,PVector a,PVector b) {
    PVector ap=PVector.sub(p,a);
    PVector ab=PVector.sub(b,a);
    ab.normalize();
    ab.mult(ap.dot(ab));
    PVector normalPoint=PVector.add(a,ab);
    return normalPoint;
    
  } 
  void applyForce(PVector f) {
    acc.add(f);
    
  } 
} 