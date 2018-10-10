function Asteroid(pos,r) {
  if(pos) {
    this.pos=pos.copy();
  }
  else {
    this.pos=createVector(random(width),random(height));
    var d=p5.Vector.dist(this.pos,ship.pos);
    if(d<50) {
      this.pos=createVector(ship.x+100,ship.y);

    }
  }
  if(r) {
    this.r=r*0.5;
  }else {
    this.r=random(15,50);
  }
  this.total=random(5,15);
  this.vel=p5.Vector.random2D();
  this.offset=[];
  for (var i=0;i<this.total;i++) {
    this.offset[i]=random(-this.r,this.r);
  }
  this.show=function() {
    push();
    translate(this.pos.x,this.pos.y);
    stroke(255);
    //ellipse(0,0,50);
    beginShape();
    for (var i=0;i<this.total;i++) {
      var angle=map(i,0,this.total,0,TWO_PI);
      var x=(this.r+this.offset[i])*cos(angle);
      var y=(this.r+this.offset[i])*sin(angle);
      vertex(x,y);
    }
    endShape(CLOSE);
    pop();
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
  this.update=function() {
    this.pos.add(this.vel);
  }
  this.breakup=function() {
    var newA=[];
    newA[0]=new Asteroid(this.pos,this.r);
    newA[1]=new Asteroid(this.pos,this.r);
    return newA;
  }
}
