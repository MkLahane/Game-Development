class Ball {
  float x;
  float y;
  float ySpeed;
  float g;
  float lift;
  color col;
  float r;
  int score = 0;

  Ball(float _x, float _y, color _col, float _r) {
    x = _x;
    y = _y;
    ySpeed = 0;
    g = 0.1;
    lift = -4;
    col = _col;
    r = _r;
  } 
  void show() {
    fill(col);
    noStroke();
    ellipse(x, y, r, r);
  } 
  void update() {

    y += ySpeed;
    y = constrain(y, 0, height - 50);
    ySpeed += g;
  } 
  void jump() {
    ySpeed = 0;
    ySpeed += lift;
  }
  boolean surpassed(Obstacle obs) {
    if (obs.center.y - obs.r - obs.r * 0.7 > y) {
      return true;
    } 
    return false;
  } 
} 
