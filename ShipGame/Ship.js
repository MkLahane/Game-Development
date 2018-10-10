function Ship(x,y) {
  this.pos=createVector(x,y);
  this.r=20;
  this.heading=0;
  this.rotation=0;
  this.vel=createVector(0,0);
  this.boost=false;

  this.thrusting=function() {
    this.boost=!this.boost;
  }
  this.update=function() {
    this.pos.add(this.vel);
    this.vel.mult(0.99);
    if(this.boost) {
      this.thrust();
    }
  }
  this.hits=function(asteroid) {
    var d=dist(this.pos.x,this.pos.y,asteroid.pos.x,asteroid.pos.y);
    if(d<this.r+asteroid.r) {
      return true;

    }else {
      return false;
    }
  }
  this.show=function() {

    push();
    fill(0);
    stroke(255);
    strokeWeight(1);

    translate(this.pos.x,this.pos.y);
    rotate(this.heading+PI/2);
    triangle(-this.r,this.r,this.r,this.r,0,-this.r);
    pop();
  }
  this.turn=function() {
    this.heading+=this.rotation;
  }
  this.thrust=function() {
    var force=p5.Vector.fromAngle(this.heading);
    force.mult(0.1);
    this.vel.add(force);

  }
  this.edges=function() {

    if(this.pos.x>width+this.r) {
      this.pos.x=-this.r;
    } else if(this.pos.x<-this.r) {
      this.pos.x=width+this.r;
    }
    if(this.pos.y>height+this.r) {
      this.pos.y=-this.r;
    } else if(this.pos.y<-this.r) {
      this.pos.y=height+this.r;
    }
  }
  this.setRotation=function(angle) {
    this.rotation=angle;
  }
}
