class Segment {
  PVector start;
  PVector end;
  float len;
  float angle;
  float selfAngle;
  float xoff;
  Segment parent=null;
  Segment child=null;
  
  Segment(float x,float y,float _len,float _angle,float xof) {
    angle=_angle;
    len=_len;
    start=new PVector(x,y);
    calculateEnd();
    parent=null;
    selfAngle=angle;
    xoff=xof;
  } 
  
   
  Segment(Segment _parent,float _len,float _angle,float xof) {
    angle=_angle;
    len=_len;
    start=new PVector(_parent.end.x,_parent.end.y);
    calculateEnd();
    parent=_parent;
    selfAngle=angle;
    xoff=xof;
  } 
  void calculateEnd() {
    float dx=len*cos(angle);
    float dy=len*sin(angle);
    end=new PVector(start.x+dx,start.y+dy);
    
  } 
  
  void wiggle() {
    //selfAngle+=0.01;
    float maxAngle=0.4;
    float minAngle=-0.4;
    selfAngle=map(noise(xoff),0,1,maxAngle,minAngle);
    xoff+=0.02;
  } 
  
  void update() {
    angle=selfAngle;
    if(parent!=null) {
      start=parent.end.copy();
      angle+=parent.angle;
      
    }else {
      angle+=-PI/2;
    } 
    
    calculateEnd();
    
  } 
  
  void show() {
   stroke(255);
   strokeWeight(4);
   line(start.x,start.y,end.x,end.y);
    
  }
} 