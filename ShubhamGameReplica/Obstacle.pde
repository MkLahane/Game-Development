class Obstacle {
  PVector pos;
  PVector acc;
  PVector vel;
  float r;
  Obstacle() {
    r = random(40, 120);
    float y = random(-100, height / 2 - r * 2);
    float x = random(1) > 0.5 ? random(-100, -50) : random(width + 50, width + 100);
    pos = new PVector(x, y);
    float velX = random(-6.2, -3.2);
    if (x < 0) {
      velX = random(3.2, 6.2);
    } 
    vel = new PVector(velX, -1.2);
    acc = new PVector(0, 0);
  } 

  Obstacle(PVector _pos, PVector _vel, float _r) {
    pos = _pos.get();
    vel = _vel.get();
    r = _r;
    acc = new PVector(0, 0);
  } 
  
  
  void show() {
    noFill();
    stroke(0);
    strokeWeight(6);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  } 
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    if ((pos.x - r >= 0 && pos.x <= r)) {
      pos.x = r;
      vel.x *= -1;
    } 
    if (pos.x + r <= width && pos.x >= width - r) {
      pos.x = width - r;
      vel.x *= -1;
    } 
    if (pos.y - r >= 0 && pos.y <= r) {
      pos.y = r;
      vel.y *= -1;
    } 
    if (pos.y >= height - r) {
      pos.y = height - r;
      vel.y *= -1;
    }
  } 
  void divide() {
    if (r > 30) {
      obstacles.add(new Obstacle(pos, new PVector(-3.2, -1.2), r * 0.5));
      obstacles.add(new Obstacle(pos, new PVector(3.2, -1.2), r * 0.5));
    }
  } 
  void checkCollision(Player player) {
    for (int i = player.bullets.size() - 1; i >= 0; i--) {
      float d = PVector.dist(player.bullets.get(i).pos, pos);
      if (d <= player.bullets.get(i).r + r) {
        player.bullets.remove(i);
        obstacles.remove(this);
        divide();
      }
    }
  } 
  void applyForce(PVector f) {
    acc.add(f);
  }
} 
