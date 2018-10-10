class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  
  Particle(PVector _pos,float m) {
    mass=m;
    pos=_pos.get();
    vel=new PVector(0,0);
    acc=new PVector(0,0);
  } 
  void show() {
    stroke(0);
    strokeWeight(2);
    fill(0,150);
    ellipse(pos.x,pos.y,mass*20,mass*20);
  } 
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    //vel.mult(0.995);
  } 
  void applyForce(PVector f) {
    PVector force=f.get();
    force.div(mass);
    acc.add(force);
  } 
   void checkEdges() {

    if (pos.x > width) {
      pos.x = width;
      vel.x *= -1;
    } else if (pos.x < 0) {
      vel.x *= -1;
      pos.x = 0;
    }

    if (pos.y > height) {
      vel.y *= -1;
      pos.y = height;
    }

  }
} 