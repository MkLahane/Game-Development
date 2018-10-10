//float r=200;
float xoff=0;
float yoff=0;
void setup() {
  size(600,600);
}
void draw() {
  
  background(0);
  translate(width/2,height/2);
  rotate(PI/2);
 
  beginShape();
  stroke(255);
  fill(255,100);
  strokeWeight(2);
  for(float a=-PI/2;a<=PI/2;a+=0.03) {
    float n=noise(xoff);
    float r=sin(2*a)*map(n,0,1,50,400);
    float x=cos(a)*r;
    float y=sin(yoff)*sin(a)*r;
    
    vertex(x,y);
    xoff+=0.1;
    //r--;
    
  } 
  //endShape();
  //beginShape();
  for(float a=PI/2;a<=3*PI/2;a+=0.03) {
    float n=noise(xoff);
    float r=sin(2*a)*map(n,0,1,50,400);
    float x=cos(a)*r;
    float y=sin(yoff)*sin(a)*r;
    
    vertex(x,y);
    xoff-=0.1;
    
  } 
  endShape();
  yoff+=0.1;
  
} 