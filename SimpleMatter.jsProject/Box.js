function Box(x,y,w) {
  this.body=Bodies.circle(x,y,w,{restitution:0.3,friction:0.1});
  this.w=w;
  World.add(world,this.body);

  this.show=function() {
    fill(126);
    push();
    translate(this.body.position.x,this.body.position.y);

    rotate(this.body.angle);
    ellipse(0,0,this.w*2);
    pop();

  }

}
