class Fluid {
  //fluid is just a rectangle
  float x,y,w,h;
  float coeffOfDrag;
  Fluid(float _x,float _y,float _w,float _h,float _coeffOfDrag) {
    coeffOfDrag=_coeffOfDrag;
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    
  }
  
   // Is the Particle in the Liquid?
  boolean contains(Particle m) {
    PVector l = m.pos.get();
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }
  
   void display() {
    noStroke();
    fill(50);
    rect(x,y,w,h);
  }
  
  PVector calculateDrag(Particle p) {
    if(contains(p)) {
      // Magnitude is coefficient * speed squared
      float speed = p.vel.mag();
      float dragMagnitude = coeffOfDrag * speed * speed;
    
      // Direction is inverse of velocity
      PVector dragForce = p.vel.get();
      dragForce.mult(-1);
      dragForce.setMag(dragMagnitude);
      return dragForce;
    }else {
       return null; 
    }
  } 

} 