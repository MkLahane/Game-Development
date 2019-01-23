class Player {
  float x; 
  final float y;
  float r;
  ArrayList<Bullet> bullets;
  int bulletsLeft = 50;
  Player(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
    bullets = new ArrayList<Bullet>();
  } 
  void show() {
    fill(80);
    stroke(0);
    strokeWeight(12);
    ellipse(x, y, r * 2, r * 2);
    for (Bullet bullet : bullets) {
      bullet.show();
    } 
    textSize(32);
    text("Bullets left:"+bulletsLeft, width - 250, 50);
  } 
  void update() {
    for (Bullet bullet : bullets) {
      bullet.update();
    } 
    for (int i = bullets.size() - 1; i >= 0; i--) {
      if (bullets.get(i).pos.y < 0) {
        bullets.remove(i);
      } 
    } 
  }
  void shoot() {
    if (bulletsLeft > 0) {
      bulletsLeft--;
      bullets.add(new Bullet(new PVector(x, y - r), new PVector(0, -15), new PVector(0, 0)));
    }
  } 
} 
