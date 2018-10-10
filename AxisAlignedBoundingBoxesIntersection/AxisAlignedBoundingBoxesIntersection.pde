
AABoundingBox b1;
AABoundingBox b2;

void setup() {
  size(700, 700);
  rectMode(CENTER);
  b1 = new AABoundingBox(new PVector(width / 2 - 100, height / 2), 50, 50);
  b2 = new AABoundingBox(new PVector(width / 2 + 100, height / 2), 50, 50);
} 

void draw() {
  background(255);
  b1.show();
  b2.show();
  b2.lock(mouseX, mouseY);
  if (checkCollision()) {
    b1.colliding = true;
    b2.colliding = true;
  } else {
    b1.colliding = false;
    b2.colliding = false;
  } 
} 

boolean checkCollision() {
  //min 
  float minXB1 = b1.center.x - b1.wR;
  float minXB2 = b2.center.x - b2.wR;
  float minYB1 = b1.center.y - b1.hR;
  float minYB2 = b2.center.y - b2.hR;
  //max 
  float maxXB1 = b1.center.x + b1.wR;
  float maxXB2 = b2.center.x + b2.wR;
  float maxYB1 = b1.center.y + b1.hR;
  float maxYB2 = b2.center.y + b2.hR;
  
 return !((minXB1 > maxXB2 || minXB2 > maxXB1) ||
  (minYB1 > maxYB2 || minYB2 > maxYB1));
} 