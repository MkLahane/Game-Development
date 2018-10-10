
float angle=PI/4;

void setup() {
  size(800,700);
 
} 

void draw() {
  background(0);
  float len=200;
  
  //line(width/2,height,width/2,height-len);
  translate(width/2,height);
  branch(len);
} 

void branch(float l) {
  stroke(255);
  line(0,0,0,-l);
  translate(0,-l);
  
  if(l>2) {
    pushMatrix();
    rotate(angle);
    branch(l*0.67);
    popMatrix();
    pushMatrix();
    rotate(-angle);
    branch(l*0.6);
    popMatrix();
  }
  //line(0,0,0,-l);
} 

void mouseWheel(MouseEvent event) {
  angle+=event.getCount()*0.1;
  
}