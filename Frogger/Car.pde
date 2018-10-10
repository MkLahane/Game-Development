class Car extends Rectangle {
   float x;
   float y;
   float w;
   float h;
   float speed;
   Car(float _x,float _y,float _w,float _h,float s) {
    super(_x,_y,_w,_h);
    x=_x;
    y=_y;
    w=_w;
    h=_h;
    speed=s;
   
    
  } 
  
  void updateCar() {
    x=x+speed;
    update(x,y,w,h);
    if(x>width+grid) {
      x=-w-grid;
    } 
    
  } 
  
   void show() {
    fill(255);
    rectMode(CORNER);
    rect(x,y,w,h);
   
   
    
  }
  
  
} 