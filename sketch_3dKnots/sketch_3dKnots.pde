float r;
float beta=0;
float angle=0;
float phi;
float theta;
ArrayList<PVector> knot;
void setup() {
  fullScreen(P3D);
  knot=new ArrayList<PVector>();
  
} 
void draw() {
  background(0);
  translate(width/2,height/2);
  rotateY(angle);
  for(int i=0;i<20;i++) {
  r=0.8+1.6*sin(6*beta)*150;
  theta=2*beta;
  phi=0.6*PI*sin(12*beta);
  float x=r*cos(phi)*cos(theta);
  float y=r*cos(phi)*sin(theta);
  float z=r*sin(phi);
  knot.add(new PVector(x,y,z));
  beta+=0.0001;
  }
  
  //lights();
  beginShape();
  for(PVector k:knot) {
    stroke(r,255,k.mag());
    noFill();
    strokeWeight(6);
    vertex(k.x,k.y,k.z);
  } 
  endShape();
  

  
  angle+=0.01;

} 