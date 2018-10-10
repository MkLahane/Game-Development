function Leaf() {
  this.pos=createVector(random(width),random(height-100));
  this.reached=false;
  this.show=function() {
    ellipse(this.pos.x,this.pos.y,4);
  }
}
