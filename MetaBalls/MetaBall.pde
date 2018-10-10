class MetaBall {
  PVector loc;
  float r;
  PVector vel;
  
  MetaBall(float x,float y) {
    loc=new PVector(x,y);
    r=70;
    vel=PVector.random2D();
    vel.mult(random(4, 8));    
  } 
  void show() {
    noFill();
    stroke(255);
    strokeWeight(4);
    ellipse(loc.x,loc.y,r*2,r*2);
  } 
  void update() {
    loc.add(vel); 
    
    if(loc.x<0 || loc.x>width) {
      vel.x*=-1; 
    }
    
    if(loc.y<0 || loc.y>height) {
      vel.y*=-1; 
    }
  }
} 
