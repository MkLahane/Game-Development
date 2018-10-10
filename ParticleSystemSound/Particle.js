function Particle(power) {
  this.pos=createVector(width/2,height/2);
  this.vel=p5.Vector.random2D();
  if(power==undefined) {
    this.vel.mult(random(-4,4));
  }else {
    console.log(power);
    this.vel.mult(power);
  }
  this.acc=createVector(0,0);

  this.show=function() {
    fill(255,100);
    ellipse(this.pos.x,this.pos.y,10,10);
  }
  this.update=function() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

}
