class Barrel {
  PVector start;
  PVector end=new PVector();
  float angle=0;
  float r=100;
  float power=20;
  
  Barrel(PVector s) {
    start=s.get();
    calculateEnd();
    
  } 
  
  void calculateEnd() {
    float dx=cos(angle)*r;
    float dy=sin(angle)*r;
    end.set(start.x+dx,start.y+dy);
    
  } 
  void update() {
    calculateEnd();
    
  } 
  
  void show() {
    stroke(255);
    strokeWeight(4);
    line(start.x,start.y,end.x,end.y);
  } 
  
  void lookFor(PVector target) {
    PVector desired=PVector.sub(target,start);
    angle=desired.heading();
  } 
  
  void setPower(float p) {
    power=p;
  } 
  
} 