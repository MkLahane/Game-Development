function Laser(x,y,angle) {
  this.pos=createVector(x,y);
  this.vel=p5.Vector.fromAngle(angle);
  this.vel.mult(10);

  this.update=function() {
    this.pos.add(this.vel);
  }
  this.show=function() {
    stroke(255);
    strokeWeight(4);
    point(this.pos.x,this.pos.y);
  }

  this.hits=function(asteroid) {
    var d=dist(this.pos.x,this.pos.y,asteroid.pos.x,asteroid.pos.y);
    if(d<asteroid.r) {
      return true;
    } else {
      return false;
    }
  }
}
