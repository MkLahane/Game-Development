function Bullet(pos,speed,angle) {
  this.pos=pos.copy();
  this.speed=speed;
  this.vel=p5.Vector.fromAngle(angle);
  this.vel.normalize();
  this.vel.mult(this.speed);

  this.show=function() {
    fill(0,200,200);
    noStroke();
    ellipse(this.pos.x,this.pos.y,10,10);
  }
  this.update=function() {
    this.pos.add(this.vel);
  }

  this.hit=function(pos,r) {
    let d=dist(pos.x,pos.y,this.pos.x,this.pos.y);
    let collided=false;
    if(d<10+r) {
      collided=true;
    }
    return collided;
  }

}
