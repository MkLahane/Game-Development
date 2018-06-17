class Snake {
  constructor() {
    this.snakes = [];
    this.snakes.push(new SnakeBodyPart(width / 2, height / 2 + 100, null));
    for (let i = 1; i < 8; i++) {
      this.snakes.push(new SnakeBodyPart(0, 0, this.snakes[i - 1]));
    }
  }
  show() {
    if (this.snakes[0]) {
      this.snakes[0].show(color(0));
    }
    for (let i = 1; i < this.snakes.length; i++) {
      let snake = this.snakes[i];
      snake.show();
    }
  }
  update() {
    for (let snake of this.snakes) {
      snake.update();
    }
  }
  checkOffscreen() {
    for (let snake of this.snakes) {
      if (snake.y + snake.r >= height) {
        return true;
      }
    }
    return false;
  }
}

class SnakeBodyPart {
  constructor(x, y, parent) {
    this.x = x;
    this.r = 20;
    this.y = y;
    this.xSpeed = 0;
    this.ySpeed = 0;
    this.parent = null;
    this.col = 255;
    if (parent != null) {
      this.parent = parent;
      this.x = this.parent.x;
      this.r = this.parent.r * 0.95;
      this.y = this.parent.y + this.r;
      this.col = this.col - 70;
    }
  }
  seek(target) {
    let desired = p5.Vector.sub(target, createVector(this.x, this.y));
    let d = desired.mag();
    //console.log(d);
    desired.normalize();
    if (d < 100) {
      desired.mult(map(d, 0, 100, 0, 5));
    }
    desired.mult(5);
    let steer = p5.Vector.sub(desired, createVector(this.xSpeed, 0));
    steer.limit(0.98);
    this.applyForce(steer);
  }
  applyForce(f) {
    this.xSpeed += f.x;
    this.ySpeed += f.y;
  }
  update() {
    if (this.parent != null) {
      this.seek(createVector(this.parent.x, this.parent.y + this.r));
    }
    this.x += this.xSpeed;
    this.y += this.ySpeed;
  }
  show(col) {
    stroke(0, this.col);
    strokeWeight(this.r);
    point(this.x, this.y);
  }
}
