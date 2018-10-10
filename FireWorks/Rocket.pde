class Rocket {
  PVector loc;
  PVector vel;
  PVector acc;
  String type;
  float lifespan=255;
 
  Rocket(PVector l,String _type) {
    loc=l.copy();
    type=_type;
    if(type=="rocket") {
      acc=new PVector(0,0,0);
      vel=new PVector(0,-10,0);
    }else if(type=="particle") {
      acc=new PVector(0,0);
      vel=PVector.random3D();
      vel.mult(random(-10,10));
      
      
    } 
    
  } 
  
  void applyForce(PVector f) {
    acc.add(f);
    
  } 
  
  void show() {
    if(type=="particle") {
      stroke(255,lifespan);
    } else {
      stroke(255);
    }
    strokeWeight(6);
    point(loc.x,loc.y,loc.z);
    
  } 
  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    if(type=="particle") {
      lifespan-=5;
      vel.mult(0.9);
    } 
   
  }

}