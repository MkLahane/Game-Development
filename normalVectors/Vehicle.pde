class Vehicle {
  PVector pos;
  PVector vel;
  PVector acc;
  float r=5;
  
  float maxspeed=10;
  
  float maxforce=0.5;
  
  float viewAngle;
  
  Vehicle() {
    pos=new PVector(random(width),random(200,400));
    vel=new PVector(random(-3,3),random(3,3));
    acc=new PVector(0,0);
    viewAngle=radians(90);
    
  } 
  
  void show() {
    float theta = vel.heading2D() + radians(90);
    //viewAngle=viewAngle+theta;
    fill(175);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(pos.x, pos.y);
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
    vel.limit(maxspeed);
    pos.add(vel);
    acc.mult(0);
  } 
  
  void border() {
    PVector desired=null;
    
    if(pos.x>width) {
      desired=new PVector(-maxspeed,vel.y);
    } else if(pos.x<0) {
      desired=new PVector(maxspeed,vel.y);
    } 
    if(pos.y>500) {
      desired=new PVector(vel.x,-maxspeed);
    } 
    if(pos.y<200) {
      desired=new PVector(vel.x,maxspeed);
    } 
    if(desired!=null) {
      desired.setMag(maxspeed);
      PVector steer=PVector.sub(desired,vel);
      steer.limit(maxforce);
      applyForce(steer);
    } 
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
  } 
  
  void scalarProjection() {
    PVector ab=PVector.sub(b,a);
    PVector ap=PVector.sub(pos,a);
    ab.normalize();
    ab.mult(ap.dot(ab));
    PVector normalPoint=PVector.add(a,ab);
    //float d=ap.magSq()-ab.magSq();
    PVector distance=PVector.sub(pos,normalPoint);
    //println("Normal Point Mag="+distance.magSq()+"   Calculate Mag="+d);
    drawScalar(normalPoint);
  } 
  
  void drawScalar(PVector normal) {
    stroke(0);
    strokeWeight(2);
    fill(255,0,0);
    ellipse(normal.x,normal.y,10,10);
    
    stroke(0);
    strokeWeight(2);
    noFill();
    line(pos.x,pos.y,normal.x,normal.y);
  } 
  
  void repel(Vehicle[] vs) {
    PVector sum=new PVector(0,0);
    int count=0;
    for(Vehicle v:vs) {
      float d=PVector.dist(v.pos,pos);
      if(d>0 && d<30) {
        PVector dirTarget=PVector.sub(v.pos,pos).normalize();
        float angleBet=PVector.angleBetween(vel,dirTarget);
        if(angleBet<viewAngle/2) {
          PVector diff=PVector.sub(pos,v.pos);
          diff.normalize();
          diff.div(d);
          sum.add(diff);
          count++;
        }
      } 
    } 
    
    if(count>0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer=PVector.sub(sum,vel);
      steer.limit(maxforce);
      applyForce(steer);
    } 
  } 
  
} 