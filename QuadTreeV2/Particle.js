// Simple class describing an ellipse living on our screen

class Particle {


  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.highlight = false;
    this.r = 8;
  }

  update() {
    this.x += random(-1, 1);
    this.y += random(-1, 1);
  }

  show() {
    stroke(0);
    strokeWeight(2);
    if (this.highlight) fill(100);
    else fill(255);
    ellipse(this.x, this.y, this.r, this.r);
  }

}
