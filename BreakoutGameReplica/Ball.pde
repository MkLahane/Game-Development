class Ball {
  PVector pos;
  float r;
  PVector vel;
  Rectangle rect; 
  ArrayList<PVector> trail;
  Ball(float x, float y, float _r) {
    r = _r;
    pos = new PVector(x, y);
    trail = new ArrayList<PVector>();
    rect = new Rectangle(pos, r, r);
    float velY = random(-12, -10);
    float velX = random(-12, -10);
    if (random(1) < 0.5) {
      velX = random(6, 4);
    } 
    vel = new PVector(velX, velY);
  } 
  void show() {
    fill(255, 200);
    ellipse(pos.x, pos.y, r * 2, r * 2);
    for (int i = 0; i < 3; i++) {
      float alpha = map(i, 0, 3, 25, 200);
      float _r = map(i, 0, 3, r * 0.1, r * 0.9);
      fill(255, alpha);
      ellipse(pos.x, pos.y, _r * 2, _r * 2);
    } 
    for (int i = 0; i < trail.size(); i++) {
      int alpha = (int)map(i, 0, trail.size(), 0, 150);
      float _r = map(i, 0, trail.size(), r * 0.2, r);
      noStroke();
      fill(255, alpha);
      ellipse(trail.get(i).x, trail.get(i).y, _r * 2, _r * 2);
    }
    //rect.show();
  }
  void update() {
    trail.add(pos.get());
    if (trail.size() >= 10) {
      trail.remove(0);
    } 
    pos.add(vel);
  } 
  void checkEdges() {
    if (pos.x < r) {
      pos.x = r;
      vel.x *= -1;
    } else if (pos.x > width - r) {
      pos.x = width - r;
      vel.x *= -1;
    } 
    if (pos.y < r) {
      pos.y = r;
      vel.y *= -1;
    } else if (pos.y > height - r) {
      pos.y = height - r;
      vel.y *= -1;
    } 
  } 
} 
