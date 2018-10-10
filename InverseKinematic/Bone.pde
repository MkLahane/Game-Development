class Bone {
  PVector start;
  PVector end=new PVector();
  int len;
  float angle=0;
  
  Bone(PVector loc,int _len) {
    start=loc.copy();
    len=_len;
    calculateEnd();
  } 
  Bone(Bone bone,int _len) {
    start=bone.end.copy();
    len=_len;
    calculateEnd();
  } 
  
  void setA(PVector pos) {
    start=pos.copy();
    calculateEnd();
  } 
  
  void calculateEnd() {
    float dx=cos(angle)*len;
    float dy=sin(angle)*len;
    end.set(start.x+dx,start.y+dy);
  } 
  
  void update() {
    calculateEnd();
  } 
  void follow(PVector target) {
    PVector desired=PVector.sub(target,start);
    angle=desired.heading();
    desired.setMag(len);
    desired.mult(-1);
    start=PVector.add(target,desired);
  } 
  
  void follow(Bone child) {
    float x=child.start.x;
    float y=child.start.y;
    follow(new PVector(x,y));
    
  } 
  
  void show() {
    stroke(255);
    strokeWeight(4);
    line(start.x,start.y,end.x,end.y);
    
  } 
  
 
  
  
} 