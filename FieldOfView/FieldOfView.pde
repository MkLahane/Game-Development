Vehicle vehicle;
ArrayList<Object>  objects;
void setup() {
  size(700,700);
  vehicle=new Vehicle(new PVector(width/2,height/2));
  objects=new ArrayList<Object>();
  for(int i=0;i<13;i++) {
    objects.add(new Object());
  } 
}

void draw() {
  background(0);
  vehicle.show();
  PVector mouse=new PVector(mouseX,mouseY);
  vehicle.seek(mouse);
  vehicle.update();
  vehicle.edges();
  for(int i=objects.size()-1;i>=0;i--) {
    objects.get(i).show();
    vehicle.whoIsVisible(objects.get(i));
    float d=PVector.dist(objects.get(i).pos,vehicle.pos);
    stroke(255,0,0);
    textSize(10);
    text(d,objects.get(i).pos.x,objects.get(i).pos.y+20);
    if(objects.get(i).isVisible) {
      if(d<80) {
        objects.remove(i);
      } 
    } 
  } 
} 