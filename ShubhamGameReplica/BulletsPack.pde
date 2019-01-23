class BulletsPack {
  PVector pos;
  float r;
  PVector vel;
  PVector acc;
  int bulletAmount;
  BulletsPack() {
    r = random(40, 120);
    float y = random(-100, height / 2 - r * 2);
    float x = random(1) > 0.5 ? random(-100, -50) : random(width + 50, width + 100);
    pos = new PVector(x, y);
    float velX = random(-6.2, -3.2);
    if (x < 0) {
      velX = random(3.2, 6.2);
    } 
    bulletAmount = floor(random(20, 70));
    vel = new PVector(velX, -1.2);
    acc = new PVector(0, 0);
  } 
  void show() {
    fill(0);
    stroke(0);
    strokeWeight(6);
    ellipse(pos.x, pos.y, r * 2, r * 2);
    fill(255);
    noStroke();
    textSize(40);
    textAlign(CENTER);
    text("Bullets", pos.x, pos.y);
    text(bulletAmount, pos.x, pos.y + 40);
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
  void applyForce(PVector f) {
    acc.add(f);
  }
} 
