System sys;
void setup() {
  size(600,600);
  sys=new System(new PVector(random(width/2,width/2+50),100));
} 


void draw() {
  background(0);
  sys.run();
  sys.addParticle();
  
  
  
} 