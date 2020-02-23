class Cell {
  int i;
  int j;
  float x;
  float y;
  float w; 
  char value;
  Cell(int _i, int _j, float startX, float startY, float _w) {
    i = _i;
    j = _j;
    w = _w;
    x = startX + j * w;
    y = startY + i * w;
    value = ' ';//(random(1) < 0.5) ? 'X' : 'O';
  } 
  void show() {
    stroke(255);
    strokeWeight(2);
    noFill();
    rect(x, y, w, w);
  }
  void showValues() {
    textSize(w / 2);
    textAlign(CENTER);
    fill(255);
    float textX = x + w / 2;
    float textY = y + w * 0.8;
    text(""+value, textX, textY);
  }
} 
