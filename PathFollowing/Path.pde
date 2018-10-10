class Path {
  PVector start;
  PVector end;
  float r;
  Path() {
    start=new PVector(0,height/3);
    end=new PVector(width,2*height/3);
    r=20;
    
  } 
  void show() {
    strokeWeight(r*2);
    stroke(0,100);
    line(start.x,start.y,end.x,end.y);
    
    strokeWeight(1);
    stroke(0);
    line(start.x,start.y,end.x,end.y);
    
  } 
  
} 