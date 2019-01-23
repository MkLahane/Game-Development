class Food extends Item {
  Food(float _x, float _y) {
    super(_x, _y, "Food", 20);
  } 
  void show() {
    stroke(0, 255, 0);
    strokeWeight(r);
    point(x, y);
  } 
 
} 