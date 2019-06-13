class Block {
  Rectangle rect;
  int health;
  color col;
  int totalHealth;
  Block (float x, float y, float _w, float _h, int _health, color _col) {
    rect = new Rectangle(new PVector(x, y), _w / 2, _h / 2);
    health = _health;
    totalHealth = _health;
    col = _col;
  } 
  void show() {
    rectMode(CENTER);
    int currentAlpha = (int)map(health, 0, totalHealth, 0, ALPHA_VAL);
    fill(col, currentAlpha);
    strokeWeight(4);
    stroke(col, currentAlpha);
    rectMode(CENTER);
    rect(rect.pos.x, rect.pos.y, rect.w * 2, rect.h * 2, 10);
    noStroke();
    for (int i = 0; i < 3; i++) {
      float alpha = map(i, 0, 5, 0, currentAlpha);
      float _w = map(i, 0, 5, 0.9 * rect.w, 0.1 * rect.w);
      float _h = map(i, 0, 5, 0.9 * rect.h, 0.1 * rect.h);
      fill(col, alpha);
      rect(rect.pos.x, rect.pos.y, _w * 2, _h * 2);
    }
  }
  boolean collides(Ball ball) {
    if (areRectsColliding(this.rect, ball.rect)) {
      handleCollision(ball, rect);
      return true;
    }
    return false;
  }
} 

void handleCollision(Ball ball, Rectangle rect) {
  ball.pos.x += -ball.vel.x * 1;
  ball.pos.y += -ball.vel.y * 1;
  //min & max for ball
  float ballMinX = ball.pos.x - ball.rect.w;
  float ballMaxX = ball.pos.x + ball.rect.w;  
  float ballMinY = ball.pos.y - ball.rect.h;
  float ballMaxY = ball.pos.y + ball.rect.h;
  //min & max for rectangle 
  float rectMinX = rect.pos.x - rect.w;
  float rectMaxX = rect.pos.x + rect.w;
  float rectMinY = rect.pos.y - rect.h;
  float rectMaxY = rect.pos.y + rect.h;
  //hit from the left 
  if (ball.vel.x > 0) {
    if (ballMaxX + 2 < rectMinX) { //left edge of brick
      ball.vel.x *= -1;
    } else if (ballMaxY + 2 < rectMinY) { //top edge of brick 
      ball.vel.y *= -1;
    } else {
      ball.vel.y *= -1; //bottom edge
    }
  } else {
    if (ballMinX + 2 > rectMaxX) { //right edge 
      ball.vel.x *= -1;
    } else if (ballMinY + 2 < rectMinY) { //top edge 
      ball.vel.y *= -1;
    } else {
      ball.vel.y *= -1; //bottome edge
    }
  }
} 
void buildBlocks() {
  int spacingX = 100;
  ROWS = 5;
  int spacingY = 30;
  //int spacingY = (height / 2 - 50) / ROWS;
  //(height / 2 - 50) / (spacingY + (spacingY) / 10);
  COLS = (width - 300) / (spacingX + (spacingX) / 10);
  blocks = new ArrayList<Block>();
  for (int i = 0; i < ROWS; i++) {
    for (int j = 0; j < COLS; j++) {
      float x = 300 / 2 + spacingX / 2 + j * (spacingX + spacingX * 0.1);
      float y = 20 + spacingY / 2 + i * (spacingY + spacingY * 0.1);
      BlocksData rData = pallete[floor(random(pallete.length))];
      blocks.add(new Block(x, y, spacingX, spacingY, rData.health, rData.col));
    }
  }
}

boolean areRectsColliding(Rectangle b1, Rectangle b2) {
  //min 
  float minXB1 = b1.pos.x - b1.w;
  float minXB2 = b2.pos.x - b2.w;
  float minYB1 = b1.pos.y - b1.h;
  float minYB2 = b2.pos.y - b2.h;
  //max 
  float maxXB1 = b1.pos.x + b1.w;
  float maxXB2 = b2.pos.x + b2.w;
  float maxYB1 = b1.pos.y + b1.h;
  float maxYB2 = b2.pos.y + b2.h;

  return !((minXB1 > maxXB2 || minXB2 > maxXB1) ||
    (minYB1 > maxYB2 || minYB2 > maxYB1));
} 
