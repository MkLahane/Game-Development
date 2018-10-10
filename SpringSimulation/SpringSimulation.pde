ArrayList<Spring> springs;
void setup() {
  size(700, 700);
  springs = new ArrayList<Spring>();
  
  for (int i = 0; i < 1; i++) {
    Spring spring = new Spring(new PVector(30 + i * 5, 30), 10, 200);
    springs.add(spring);
  }
} 

void draw() {
  background(255);
  for (Spring spring : springs) {
    spring.show();
    spring.springSim();
    spring.update();
  }
} 

//void mouseDragged() {
//  spring.anchor.set(mouseX, mouseY);
//} 
