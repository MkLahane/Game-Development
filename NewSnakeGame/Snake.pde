class Snake {
  Snake parent;
  float x;
  float y;
  float r = 20;
  float xSpeed = 0;
  float ySpeed = 0;
  boolean first = false;
  Snake(float _x, float _y) {
    x = _x;
    y = _y;
    parent = null;
    first = true;
  } 
  Snake(Snake _parent) {
    parent = _parent;
    x = parent.x;
    y = parent.y + r;
    r = parent.r * 0.97;
  } 
  void show() {
    if (first) {
      stroke(0);
    } else {
      stroke(0, 175);
    } 
    strokeWeight(r);
    point(x, y);
  } 

  void applyForce(PVector f) {
    xSpeed += f.x;
    ySpeed += f.y;
  } 
  boolean checkEaten(Item food) {
    return (dist(food.x, food.y, x, y) < r + food.r);
  } 
  void seek(PVector target) {
    PVector desired = PVector.sub(target, new PVector(x, y));
    float d = desired.mag();
    desired.normalize();
    if (d < 100) {
      desired.mult(map(d, 0, 100, 0, 8));
    } else {
      desired.mult(8);
    } 
    PVector steer = PVector.sub(desired, new PVector(xSpeed, ySpeed));
    steer.limit(0.5);
    applyForce(steer);
  } 
  void update() {
    if (parent != null) {
      seek(new PVector(parent.x, parent.y + r));
    }
    x += xSpeed * 3;
    y += ySpeed;
  }
  boolean collided(Item item) {
    return abs(y - item.y) <= item.h + r / 2 && (abs(item.x - x) < 30);
  } 
} 