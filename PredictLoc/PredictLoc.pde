Vehicle v;
void setup() {
  size(600,600);
  v=new Vehicle(width/2,height/2);
  smooth();
} 

void draw() {
  background(255);
  v.run();
  v.wander();
}