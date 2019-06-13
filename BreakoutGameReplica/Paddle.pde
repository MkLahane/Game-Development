class Paddle {
  float xVel; 
  Rectangle rect;
  int score = 0;
  Paddle(float x, float y, float _w) {
    rect = new Rectangle(new PVector(x, y), _w / 2, 10);
  }
  void show() {
    fill(255);
    noStroke();
    rect(rect.pos.x, rect.pos.y, rect.w * 2, rect.h * 2, 10);
    noFill();
    for (int i = 0; i < 10; i++) {
      float w = map(i, 0, 10, rect.w * 0.1, rect.w * 0.8);
      float h = map(i, 0, 10, rect.h * 0.1, rect.h * 0.8);
      int strokeWt = (int) map(i, 0, 10, 0, 3);
      stroke(0);
      strokeWeight(strokeWt);
      rectMode(CENTER);
      rect(rect.pos.x, rect.pos.y, w * 2, h * 2);
    } 
    fill(250, 200, 100, 200);
    textSize(60);
    text("Score:"+score, 20, height - 50);
    //rect.show();
  } 
  void update() {
    rect.pos.x += xVel;
    rect.pos.x = constrain(rect.pos.x, rect.w, width - rect.w);
  }
  void setXVelocity(float _xVel) {
    xVel = _xVel;
  }
  void collides(Ball ball) {
    if (areRectsColliding(this.rect, ball.rect)) { 
      tapSound.stop();
      tapSound.play();
      //ball.pos.y = ball.pos.y - ball.vel.y;//this.rect.pos.y - this.rect.h;
      //ball.vel.y *= -1;
      handleCollision(ball, this.rect);
    }
  }
} 
