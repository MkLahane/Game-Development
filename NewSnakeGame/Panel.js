class Panel {
  constructor() {
    this.items = [];
    this.addItems();
  }
  addItems() {
    // //all Blocks
    // let r = random(1);
    // if (r < 0.1) {
    //   for (let i = 0; i < cols; i++) {
    //     let x = i * spacingCol;
    //     let y = -100;
    //     this.items.push(new Block(x, y, spacingCol, spacingCol));
    //   }
    // } else if (r < 0.5) { //1 food other all are blocks
    //   let x = 0 * spacingCol + spacingCol / 2;
    //   let y = -100 + spacingCol / 2;
    //   this.items.push(new Food(x, y, 10));
    //   for (let i = 1; i < cols; i++) {
    //     let x = i * spacingCol;
    //     let y = -100;
    //     this.items.push(new Block(x, y, spacingCol, spacingCol));
    //   }
    // } else { //only 1 food
    //   let x = floor(random(0, cols - 1)) * spacingCol + spacingCol / 2;
    //   this.items.push(new Food(x, -100, 10));
    // }
    for (let i = 0; i < cols; i++) {
      let rn = random(1);
      if (rn < 0.2) {
        //add food
        let x = i * spacingCol + spacingCol / 2;
        let y = -100 + spacingCol / 2;
        this.items.push(new Food(x, y, 10));
      } else {
        let x = i * spacingCol;
        let y = -100;
        this.items.push(new Block(x, y, spacingCol, spacingCol));
      }
    }
  }
  show() {
    for (let item of this.items) {
      item.show();
    }
  }
  update() {
    for (let item of this.items) {
      item.update();
    }
  }
  offscreen() {
    for (let item of this.items) {
      if (item.y > height / 2 + 200) {
        return true;
      }
    }
  }
  check(sn) {
    if (sn.snakes.length <= 0) {
      return false;
    }
    for (let i = this.items.length - 1; i >= 0; i--) {
      let item = this.items[i];
      if (item.check(sn)) {
        this.items.splice(i, 1);
        if (item instanceof Food) {
          return true;
        }
      }
    }
    return false;
  }

}

class Food {
  constructor(x, y, r) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.ySpeed = 4;
    this.number = floor(random(1, 7));
  }
  show() {
    noStroke();
    fill(0);
    textSize(32);
    text(this.number, this.x, this.y - 10);
    noFill();
    stroke(0, 255, 0, 100);
    strokeWeight(this.r);
    point(this.x, this.y);
  }
  update() {
    this.y += this.ySpeed;
  }
  check(sn) {
    if (sn.snakes.length > 0) {
      if (dist(sn.snakes[0].x, sn.snakes[0].y, this.x, this.y) <= sn.snakes[0].r + this.r) {
        for (let i = 0; i < this.number; i++) {
          sn.snakes.push(new SnakeBodyPart(0, 0, sn.snakes[sn.snakes.length - 1]));
        }
        panelLogic.addPanel();
        return true;
      }
    }
    return false;
  }
}

class Block {
  constructor(x, y, w, h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.ySpeed = 4;
    this.number = floor(random(3, 10));
  }
  show() {
    fill(0, 100);
    strokeWeight(2);
    stroke(0);
    rect(this.x, this.y, this.w, this.h);
    fill(0);
    textSize(32);
    text(this.number, this.x + this.w / 2 - 10, this.y + this.h / 2 + 15);
  }

  check(sn) {
    if (sn.snakes.length > 0) {
      let bX = this.x + this.w / 2;
      let sX = round(sn.snakes[0].x);
      if (abs(bX - sX) < 1) {
        let diffY = sn.snakes[0].y - this.y;
        if (diffY <= this.h && diffY >= 0) {
          this.removeSnakeParts(sn);
          return true;
        }
      }
    }
    return false;
  }
  removeSnakeParts(sn) {
    if (sn.snakes.length - this.number <= 0) {
      noLoop();
      return;
    }
    for (let i = 0; i < this.number; i++) {
      sn.snakes.pop();
    }
  }
  update() {
    this.y += this.ySpeed;
  }
}
