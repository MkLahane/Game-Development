
int rows,cols;
int scl=20;
float fly=0;
float terrain[][];
void setup() {
  size(1350,800,P3D);
  rows=2000/scl;
  cols=2000/scl;
  terrain=new float[rows][cols];
  
} 

void draw() {
 
  float yoff=fly;
  for(int y=0;y<rows;y++) {
    float xoff=0;
    for(int x=0;x<cols;x++) {
      terrain[y][x]=map(noise(yoff,xoff),0,1,-350,350);
      xoff+=0.1;
    } 
    yoff+=0.1;
  }
  
  background(0);
  translate(width/2,height/2);
  fill(0,255,0);
  //noFill();
  //noStroke();
  
  rotateX(PI/3);
  
  translate(-width/2-300,-height/2);
  
  
  for(int y=0;y<rows-1;y++) {
    beginShape(TRIANGLE_STRIP);
    for(int x=0;x<cols;x++) {
      vertex(x*scl,y*scl,terrain[y][x]);
      vertex(x*scl,(y+1)*scl,terrain[y+1][x]);
      
    } 
    endShape();
    
  }
  
  fly+=-0.07;
} 