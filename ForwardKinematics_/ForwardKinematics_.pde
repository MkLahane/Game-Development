Segment tentacle;

void setup() {
  size(600,600);
  float t=0;
  tentacle=new Segment(300,height,10,0,t);
  Segment current=tentacle;
  for(int i=0;i<60;i++) {
    t+=0.1;
    Segment next=new Segment(current,10,0,t);
    current.child=next;
    current=next;
  } 
} 

void draw() {
  background(0);
  Segment next=tentacle;
  while(next!=null) {
    next.wiggle();
    next.update();
    next.show();
    next=next.child;
  }
  
  
  
} 