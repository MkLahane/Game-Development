class Rectangle {
  PVector pos;
  float w;
  float h;
  Rectangle (PVector _pos, float _w, float _h) {
    pos = _pos;
    w = _w;
    h = _h;
  } 
  void show() {
    stroke(255);
    noFill();
    strokeWeight(2);
    rect(pos.x, pos.y, w * 2, h * 2);
  } 
} 
