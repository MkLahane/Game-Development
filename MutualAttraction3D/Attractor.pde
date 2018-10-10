class Attractor {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  Attractor(PVector _pos,float _mass) {
    pos=_pos.get();
    vel=new PVector(0,0,0);
    acc=new PVector(0,0,0);
    mass=_mass;
  } 
  void show() {
    stroke(0,255,0);
    noFill();
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateY(angle);
    sphere(mass*2);
    popMatrix();
  } 
  PVector calculateGravity(Mover m) {
    PVector forceDir=PVector.sub(pos,m.pos);
    float dist=forceDir.magSq();
    forceDir.normalize();
    float forceMag=(1.5*m.mass*mass)/dist;
    forceDir.mult(forceMag);
    return forceDir;
  } 
} 