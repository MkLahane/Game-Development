class Cell {
  float x;
  float y;
  int i;
  int j;
  color gColor;
  float spacing;
  Cell (int _i, int _j, color _gColor, float _spacing) {
    i = _i;
    j = _j;
    gColor = _gColor;
    spacing = _spacing;
    x = j * spacing + offset;
    y = i * spacing + offset;
  } 
  void show() {
    fill(gColor);
    noStroke();
    //stroke(255);
    rect(x, y, spacing, spacing);
  } 
  
  
} 
