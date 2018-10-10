function  Branch(pos,parent,dir) {
  this.pos=pos;
  this.parent=parent;
  this.dir=dir;
  this.count=0;
  this.originalDir=this.dir.copy();
  this.reset=function() {
    this.count=0;
    this.dir=this.originalDir;
  }

  this.next=function() {
    //this.dir.normalize();
    var nextDir=p5.Vector.mult(this.dir,5);
    var nextPos=p5.Vector.add(this.pos,nextDir);
    var nextBranch=new Branch(nextPos,this,this.dir.copy());
    return nextBranch;
  }
  this.show=function(i,len) {
    var sw=map(i,0,len,10,1);
    if(this.parent!=null) {
      strokeWeight(sw);
      stroke(255);
      line(this.pos.x,this.pos.y,this.parent.pos.x,this.parent.pos.y);
    }
  }
}
