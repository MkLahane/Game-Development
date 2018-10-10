Mover chaser;
Mover evader;
float d=50;
void setup() {
 size(600,600); 
  chaser=new Mover(new PVector(300,300),1);
  evader=new Mover(new PVector(300,200),-1);
}

void draw() {
  background(0);
  chaser.show();
  evader.show();
  chaser.update();
  evader.update();
  noFill();
  stroke(255);
  
  rect(d,d,abs(d-(width-d)),abs(d-(height-d)));
  PVector steerC=chaser.ChaseorEvade(evader);
  
  PVector steerE=evader.ChaseorEvade(chaser);
  PVector steerBC=chaser.border();
  PVector steerBE=evader.border();
  steerC.mult(2);
  steerE.mult(2);
  steerBC.mult(4);
  steerBE.mult(4);
  chaser.applyForce(steerC);
  chaser.applyForce(steerBC);
  evader.applyForce(steerE);
  evader.applyForce(steerBE);
}