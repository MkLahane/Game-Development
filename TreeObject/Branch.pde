class Branch {
  PVector start;
  PVector end;
  boolean branched=false;
  
  Branch(PVector _start,PVector  _end) {
    start=_start;
    end=_end;
    
  } 
  void show() {
    stroke(255);
    noFill();
    line(start.x,start.y,end.x,end.y);
    
  } 
  Branch branchRight() {
   
    PVector dir=PVector.sub(end,start);
    dir.rotate(PI/4);
    dir.mult(0.6);
    PVector newEnd=PVector.add(end,dir);
    Branch right=new Branch(end,newEnd);
    return right;
    
  } 
   Branch branchLeft() {
    PVector dir=PVector.sub(end,start);
    dir.rotate(-PI/4);
    dir.mult(0.6);
    PVector newEnd=PVector.add(end,dir);
    Branch left=new Branch(end,newEnd);
    return left;
    
  } 
  
  
} 