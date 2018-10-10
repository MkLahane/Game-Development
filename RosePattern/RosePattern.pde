float k1=5/2.0;
float a1=0;
ArrayList<PVector> flower1;

float k2=8.0/5;
float a2=0;
ArrayList<PVector> flower2;

float k3=2.0/5;
float a3=0;
ArrayList<PVector> flower3;

void setup() {
  size(1400,800);
  //fullScreen();
  println(5.0/8);
  flower1=new ArrayList<PVector>();
  flower2=new ArrayList<PVector>();
  flower3=new ArrayList<PVector>();
  //colorMode(HSB);
} 

void draw() {
  background(0);
  beginShape();
  noFill();
  stroke(200,0,200);
  strokeWeight(2);
  noFill();
  for(PVector vec:flower1) {
    vertex(vec.x,vec.y);
  } 
  endShape();
  stroke(0,255,0);
  strokeWeight(2);
  beginShape();
  for(PVector vec:flower2) {
    vertex(vec.x,vec.y);
  } 
  endShape();
  stroke(0,0,200);
  strokeWeight(2);
  beginShape();
  for(PVector vec:flower3) {
    vertex(vec.x,vec.y);
  } 
  endShape();
  
  float r1=200*cos(k1*a1);
  float x1=width/2+r1*cos(a1);
  float y1=height/2+r1*sin(a1);
  flower1.add(new PVector(x1,y1));
  a1+=0.04;
  
  float r2=300*cos(k2*a2);
  float x2=width/2+r2*cos(a2);
  float y2=height/2+r2*sin(a2);
  flower2.add(new PVector(x2,y2));
  a2+=0.04;
  
  float r3=400*cos(k3*a3);
  float x3=width/2+r3*cos(a3);
  float y3=height/2+r3*sin(a3);
  flower3.add(new PVector(x3,y3));
  a3+=0.04;
  
} 