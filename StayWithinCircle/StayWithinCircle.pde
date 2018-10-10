PVector circleLoc;
float radiusOfCircle=200;
Vehicle vehicle;
void setup() {
  size(700,700);
  circleLoc=new PVector(width/2,height/2);
  vehicle=new Vehicle();
} 


void draw() {
  background(255);
  fill(0,100);
  ellipse(circleLoc.x,circleLoc.y,radiusOfCircle*2,radiusOfCircle*2);
  vehicle.show();
  vehicle.update();
  vehicle.stayWithin();
  
} 