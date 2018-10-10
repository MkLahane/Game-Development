//Quadratic Beizer Curve 

Vehicle vehicle;

int count=0;

float time=0;
PVector start=new PVector(300,600);
PVector control1=new PVector(300,100);
PVector control2=new PVector(300,500);
PVector end=new PVector(500,600);
ArrayList<PVector> pFinals=new ArrayList<PVector>();


void setup() {
  size(1000,700);
  pFinals.clear();
  vehicle=new Vehicle(random(width),random(height));

}


void draw() {
  background(0);
  vehicle.show();
  vehicle.update();
  
  println(pFinals.size());
  
  stroke(255,0,0);
  noFill();
  ellipse(start.x,start.y,10,10);
  ellipse(control1.x,control1.y,10,10);
  ellipse(control2.x,control2.y,10,10);
  ellipse(end.x,end.y,10,10);
  
  cubicBeizerCurve(start,control1,control2,end,time);

  time+=0.001;
  
  for(PVector pFinal:pFinals) {
    stroke(255);
    strokeWeight(2);
    beginShape();
    vertex(pFinal.x,pFinal.y);
    endShape();
    
  } 
  if(time>1) {
    follow();
    
  } 
  //println(time);
  
} 

void  quadbeizerCurve(PVector p0,PVector p1,PVector p2,float t) {
  if(t<=1) {
    PVector pFinal=new PVector();
    pFinal.x=pow(1-t,2)*p0.x+(1-t)*2*t*p1.x+t*t*p2.x;
    pFinal.y=pow(1-t,2)*p0.y+(1-t)*2*t*p1.y+t*t*p2.y;
    pFinals.add(pFinal);
  }
} 

void cubicBeizerCurve(PVector p0,PVector p1,PVector p2,PVector p3,float t) {
  PVector pFinal=new PVector();
  if(t!=1) {
    pFinal.x=pow(1-t,3)*p0.x+pow(1-t,2)*3*t*p1.x+(1-t)*3*t*t*p2.x+t*t*t*p3.x;
    
    pFinal.y=pow(1-t,3)*p0.y+pow(1-t,2)*3*t*p1.y+(1-t)*3*t*t*p2.y+t*t*t*p3.y;
    if(pFinals.size()<1500) {
      pFinals.add(pFinal);
    }
    
  } 
  
} 

void follow() {
  if(count>=pFinals.size()) {
    count=0;
  } 
  
  vehicle.seek(pFinals.get(count));
  float d=PVector.dist(vehicle.pos,pFinals.get(count));
  if(d<10) {
    count++;
    
  } 
  
 
  
} 

void getToStart() {
  vehicle.seek(start);
  
} 