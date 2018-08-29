class Button {
  PVector pos;
  float sizeX;
  float sizeY;
  String value;
  Button(String _value, PVector _pos, float _sizeX, float _sizeY) {
    sizeX = _sizeX;
    sizeY = _sizeY;
    pos = _pos.get();
    value = _value;
  } 
  void show() {
    fill(0, 50);
    stroke(0);
    strokeWeight(2);
    rect(pos.x, pos.y, sizeX, sizeY);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(value, pos.x + sizeX / 2, pos.y + sizeY / 2 + 10);
  } 
  boolean pressed() {
    return (mouseX >= pos.x && mouseX <= pos.x + sizeX && mouseY >= pos.y && mouseY <= pos.y + sizeY);
  } 
} 
