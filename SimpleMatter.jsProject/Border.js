function Boundary(x,y,w,h,a) {
  this.options={
    isStatic:true,
    friction:0,
    angle:a
  }
  this.body=Bodies.rectangle(x,y,w,h,this.options);
  this.h=h;
  this.w=w;
  World.add(world,this.body);

  this.show=function() {

    push();
    translate(this.body.position.x,this.body.position.y);
    rotate(this.body.angle);
    rectMode(CENTER);
    strokeWeight(2);
    stroke(255);
    fill(0);
    rect(0,0,this.w,this.h);
    pop();

  }

}
