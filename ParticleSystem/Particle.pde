class Particle {
  PVector loc;
  PVector acc;
  PVector vel;
  float lifespan=255;
  Particle(PVector l) {
    lifespan=255;
    loc=l.get();
    acc=new PVector(random(-2,2),random(3,5));
    vel=new PVector(0,0);
  } 
  void show() {
    fill(255,lifespan);
    ellipse(loc.x,loc.y,10,10);
    
  } 
  
  void update() {
    vel.add(acc);
    vel.limit(4);
    loc.add(vel);
    acc.mult(0);
    lifespan-=2;
  }
  
  
} 