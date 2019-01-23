class Block extends Item {
  Block(float _x, float _y, float _w, float _h, int _number) {
    super(_x, _y, "Block", _w, _h, _number);
    
  } 
  void show() {
    stroke(0);
    fill(0, 100);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER);
    textSize(40);
    text(number, x + w / 2, y + h / 2 + 15);
  } 
} 