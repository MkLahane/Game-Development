Vehicle vehicle;
void setup() {
  size(600,600);
  vehicle=new Vehicle(new PVector(width/2,height/2));
} 

void draw() {
  background(0);
  vehicle.show();
  vehicle.update();
  PVector mouse=new PVector(mouseX,mouseY);
  vehicle.seek(mouse);
  vehicle.borders();
  
  
  
} 