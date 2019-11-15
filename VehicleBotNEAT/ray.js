class Ray {
    constructor(pos, a) {
      this.pos = pos;
      this.angle = a;
      this.dir = p5.Vector.fromAngle(this.angle);
    }
    rotate(offset) {
      //console.log("Old:"+this.dir);
      this.angle += offset;
      this.dir = p5.Vector.fromAngle(this.angle + offset);
      ///console.log("New:"+this.dir);
    }
    lookAt(x, y) {
      let temp = createVector(x, y);
      this.dir = temp.sub(this.pos);
      this.dir.normalize();
    }
    show() {
      stroke(255);
      noFill();
      strokeWeight(2);
      push();
      translate(this.pos.x, this.pos.y);
      line(0, 0, this.dir.x * SIGHT, this.dir.y * SIGHT);
      pop();
    }
    cast(wall) {
      let x1 = wall.a.x;
      let y1 = wall.a.y;
  
      let x2 = wall.b.x;
      let y2 = wall.b.y;
  
      let x3 = this.pos.x;
      let y3 = this.pos.y;
  
      let x4 = this.pos.x + this.dir.x;
      let y4 = this.pos.y + this.dir.y;
  
      let denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  
      if (denominator == 0) { //the wall and the ray are parallel
        return {isCasting : false, pos : null};
      }
      let t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator;
      let u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denominator;
  
      if (t >= 0 && t <= 1 && u > 0) {
        let x = x1 + t * (x2 - x1);
        let y = y1 + t * (y2 - y1);
        return {isCasting : true, pos : createVector(x, y)};
      }
      return {isCasting : false, pos : null};
    }
  }
  