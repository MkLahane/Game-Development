function Tree() {
  this.leaves=[];
  this.branches=[];
  for(var i=0;i<1000;i++) {
      this.leaves.push(new Leaf());
  }
  var dir=createVector(0,-1);
  var pos=createVector(width/2,height);
  var root=new  Branch(pos,null,dir);
  this.branches.push(root);
  var found=false;
  var current=root;
  while(!found) {
    for(var i=0;i<this.leaves.length;i++) {
      var d=p5.Vector.dist(current.pos,this.leaves[i].pos);
      if(d<max_dist) {
        found=true;
      }
    }
    if(!found) {
      var branch=current.next();
      current=branch;
      this.branches.push(current);
    }
  }

  this.grow=function() {
    for(var i=0;i<this.leaves.length;i++) {
      var leaf=this.leaves[i];
      var closest=null;
      var record=100000000;
      for(var j=0;j<this.branches.length;j++) {
        var branch=this.branches[j];
        var d=p5.Vector.dist(leaf.pos,branch.pos);
        if(d<min_dist) {
          leaf.reached=true;
          closest=null;
          break;
        }else if(d>max_dist) {

        }else if(closest==null||d<record) {
          closest=branch;
          record=d;
        }
      }
      if(closest!=null) {
        var desired=p5.Vector.sub(leaf.pos,closest.pos);
        desired.normalize();
        closest.dir.add(desired);
        closest.count++;
      }
    }
    for(var i=this.leaves.length-1;i>=0;i--) {
      if(this.leaves[i].reached) {
        this.leaves.splice(i,1);
      }
    }
    for(var i=this.branches.length-1;i>=0;i--) {
      var branch=this.branches[i];
      if(branch.count>0) {
        branch.dir.div(branch.count+1);
        // var newPos=p5.Vector.add(branch.pos,branch.dir);
        // var newBranch=new Branch(newPos,branch,branch.dir.copy());
        // this.branches.push(newBranch);
        this.branches.push(branch.next());
      }
      branch.reset();
    }
  }

  this.show=function() {
    for(var i=0;i<this.leaves.length;i++) {
      this.leaves[i].show();
    }
    for(var i=0;i<this.branches.length;i++) {
       this.branches[i].show(i,this.branches.length);
    }
  }
}
