Particle p1;
Particle p2;
Particle p3;
Particle p4; 
void setup() {
  size(700, 700);
  p1 = new Particle(new PVector(100, 100), random(1.5, 10));
  p2 = new Particle(new PVector(600, 600), random(1.5, 10));
  p3 = new Particle(new PVector(100, 600), random(1.5, 10));
  p4 = new Particle(new PVector(600, 100), random(1.5, 10));
} 
void draw() {
  background(255);
  p1.show(color(0, 100, 200));
  p2.show(color(200, 0, 70));
  p3.show(color(200, 0, 200));
  p4.show(color(200, 200, 0));
  p3.update();
  p1.update();
  p2.update();
  p4.update();
  p3.checkEdges();
  p4.checkEdges();
  p1.checkEdges();
  p2.checkEdges();
  p1.checkCollision(p2);
  p1.checkCollision(p3);
  p1.checkCollision(p4);
  p2.checkCollision(p3);
  p2.checkCollision(p4);
  p3.checkCollision(p4);

  
}
