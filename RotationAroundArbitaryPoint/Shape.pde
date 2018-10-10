class Shape {
  PVector origin;
  PVector a;
  PVector c;
  PVector b;
  PVector d;
  float wR;
  float hR;
  boolean colliding = false;
  Shape(PVector _origin, float _wR, float _hR) {
    wR = _wR;
    hR = _hR;
    origin = _origin.get();
    setVertices();
  } 
  void setVertices() {
    a = new PVector(origin.x - wR, origin.y - hR);
    b = new PVector(origin.x + wR, origin.y - hR);
    c = new PVector(origin.x + wR, origin.y + hR);
    d = new PVector(origin.x - wR, origin.y + hR);
  } 
  void show() {
    noFill();
    if (colliding) {
      stroke(0, 255, 0);
    } else {
      stroke(0);
    }
    strokeWeight(2);
    beginShape();
    vertex(getX(a.x), getY(a.y));
    vertex(getX(b.x), getY(b.y));
    vertex(getX(c.x), getY(c.y));
    vertex(getX(d.x), getY(d.y));
    endShape(CLOSE);
  } 
} 