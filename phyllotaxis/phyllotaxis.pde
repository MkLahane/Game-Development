float n = 0;
float c = 2;
void setup() {
  size(700, 700);
  background(255);
} 


void draw() {
  
  float angle = 137.5 * n;
  float radius = c * sqrt(n);
  float x = cos(angle) * radius + width / 2;
  float y = sin(angle) * radius + height / 2;
  
  strokeWeight(10);
  stroke(0, 50);
  point(x, y);
  n++;
} 
