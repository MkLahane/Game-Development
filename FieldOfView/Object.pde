class Object {
  PVector pos;
  boolean isVisible;
  
  Object() {
    pos=new PVector(random(width),random(height));
    isVisible=false;
  } 
  
  void show() {
    if(isVisible) {
      fill(255,0,0);
    } else {
      fill(0,255,0);
    } 
    
    ellipse(pos.x,pos.y,20,20);
  } 
} 