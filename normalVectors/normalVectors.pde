Vehicle[] vehicles;

PVector a;
PVector b;

void setup() {
  size(700,700);
  vehicles=new Vehicle[15];
  for(int i=0;i<vehicles.length;i++) {
    vehicles[i]=new Vehicle();
  }
  a=new PVector(0,600);
  b=new PVector(width,670);
} 

void draw() {
  background(255);
  for(Vehicle vehicle:vehicles) {
    vehicle.show();
    vehicle.update();
    vehicle.border();
    vehicle.scalarProjection();
    vehicle.repel(vehicles);
  }
  stroke(0);
  strokeWeight(1);
  noFill();
  rect(0,200,width,300);
  
  fill(255,0,0);
  stroke(0);
  ellipse(a.x,a.y,10,10);
  
  stroke(0);
  strokeWeight(4);
  line(a.x,a.y,b.x,b.y);
  
   
  fill(255,0,0);
  stroke(0);
  ellipse(b.x,b.y,10,10);
  
  
} 