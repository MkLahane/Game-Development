Path path;
ArrayList<Vehicle>  cars=new ArrayList<Vehicle>();

void setup() {
  size(600,600);
  path=new Path();
  for(int i=0;i<2;i++) {
    cars.add(new Vehicle(new PVector(random(width),random(height)),random(3,7),random(0.2,1)));
    
  } 
} 

void draw() {
 background(255); 
 path.show();
 for(Vehicle v:cars) {
   v.display();
   v.update();
   v.Follow(path);
   v.border();
   v.separate(cars);
 } 
} 

void mouseDragged() {
  cars.add(new Vehicle(new PVector(mouseX,mouseY),random(3,7),random(0.2,1)));
  
} 