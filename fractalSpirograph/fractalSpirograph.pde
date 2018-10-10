Orbit sun;
int resolution=10;
Orbit end;
float kTotal1=-8;
float kTotal2=-4;
float kTotal3=-11;
float kTotal4=-7;
ArrayList<PVector> path1;
ArrayList<PVector> path2;
ArrayList<PVector> path3;
Orbit sun3;
Orbit sun2;
Orbit end2;
Orbit end3;
Orbit end4;
Orbit sun4;

ArrayList<PVector> path4;
void setup() {
  size(1400,800);
  path1=new ArrayList<PVector>();
  path2=new ArrayList<PVector>();
  path3=new ArrayList<PVector>();
  path4=new ArrayList<PVector>();
  sun=new Orbit(300,220,0,kTotal1,100);
  sun2=new Orbit(1000,220,0,kTotal2,100);
  sun3=new Orbit(300,600,0,kTotal3,100);
  sun4=new Orbit(1000,600,0,kTotal4,100);
  Orbit current=sun;
  for(int i=0;i<20;i++) {
    current=current.addOrbit();
  } 
  end=current;
  Orbit current2=sun2;
  for(int i=0;i<20;i++) {
    current2=current2.addOrbit();
  } 
  end2=current2;
  Orbit current3=sun3;
  for(int i=0;i<20;i++) {
    current3=current3.addOrbit();
  } 
  end3=current3;
  Orbit current4=sun4;
  for(int i=0;i<20;i++) {
    current4=current4.addOrbit();
  } 
  end4=current4;
} 

void draw() {
  background(0);
  
  for(int i=0;i<resolution;i++) {
    Orbit next=sun;
    while(next!=null) {
      //next.show();
      next.update();
      next=next.child;
    } 
    path1.add(new PVector(end.x,end.y));
  }
  for(int i=0;i<resolution;i++) {
    Orbit next=sun2;
    while(next!=null) {
      //next.show();
      next.update();
      next=next.child;
    } 
    path2.add(new PVector(end2.x,end2.y));
  }
   for(int i=0;i<resolution;i++) {
    Orbit next=sun3;
    while(next!=null) {
      //next.show();
      next.update();
      next=next.child;
    } 
    path3.add(new PVector(end3.x,end3.y));
  }
   for(int i=0;i<resolution;i++) {
    Orbit next=sun4;
    while(next!=null) {
      //next.show();
      next.update();
      next=next.child;
    } 
    path4.add(new PVector(end4.x,end4.y));
  }
  //println(end.x,end.y);
  beginShape();
  noFill();
  stroke(255,0,0);
  strokeWeight(2);
  for(PVector pos:path1) {
    vertex(pos.x,pos.y);
  } 
  endShape();
  
  beginShape();
  noFill();
  stroke(0,255,0);
  strokeWeight(2);
  for(PVector pos:path3) {
    vertex(pos.x,pos.y);
  } 
  endShape();
  
    
  beginShape();
  noFill();
  stroke(200,0,200);
  strokeWeight(2);
  for(PVector pos:path2) {
    vertex(pos.x,pos.y);
  } 
  endShape();
  
  beginShape();
  noFill();
  stroke(200,200,0);
  strokeWeight(2);
  for(PVector pos:path4) {
    vertex(pos.x,pos.y);
  } 
  endShape();
  //println(kTotal);
  
} 