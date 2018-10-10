//Axis-Aligned-Bounding-Box implementation
class AABoundingBox {
  PVector center;
  boolean colliding = false;
  float wR;
  float hR;
  AABoundingBox(PVector _center, float _wR, float _hR) {
    wR = _wR;
    hR = _hR;
    center = _center.get();
  } 
  void show() {
    if (colliding) {
      stroke(0, 255, 0);
    } else {
      stroke(0);
    }
    noFill();
    strokeWeight(2);
    rect(center.x, center.y, wR * 2, hR * 2);
  } 
  void lock(float x, float y) {
    center.set(x, y);
  } 
} 