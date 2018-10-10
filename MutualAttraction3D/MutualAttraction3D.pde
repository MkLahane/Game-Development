Attractor attractor;
float angle=0;
Mover mover;
void setup() {
  size(700,700,P3D);
  attractor=new Attractor(new PVector(width/2,height/2,width/2),20);
  mover=new Mover(new PVector(width/2,height/2,width/2+100),5);
} 

void draw() {
  background(0);
  attractor.show();
  angle+=0.03;
  mover.show();
  mover.update();
  PVector gravity=attractor.calculateGravity(mover);
  mover.applyForce(gravity);
} 