Vehicle vehicle;
void setup() {
  fullScreen(P3D);
  vehicle=new Vehicle(new PVector(width/2,height/2,100));
} 

void draw() {
  background(0);
  lights();
  PVector mouse=new PVector(mouseX,mouseY,abs(mouseY-mouseX));
  //translate(mouse.x,mouse.y,mouse.z);
  //sphere(50);
  vehicle.show();
  vehicle.update();
  
  vehicle.seek(mouse);
} 