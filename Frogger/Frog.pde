class Frog extends Rectangle {
  Log attached=null;
  float x,y,w;
  Frog(float _x,float _y,float _w) {
    super(_x,_y,_w,_w);
    x=_x;
    y=_y;
    w=_w;
   
    
  } 
  void attach(Log log) {
    attached=log;
    
  } 
  void show() {
    fill(0,255,0);
    //rectMode(CORNER);
    rect(x,y,w,w);
   
    
  }
  void updateByLog() {
   if(attached!=null) {
     x+=attached.speed;
     
   } 
   frog.x=constrain(x,0,width-w);
    
  }
  void move(float xdir,float ydir) {
    x+=xdir*grid;
    y+=ydir*grid;
    update(x,y,w,w);
    if(x>width||x<0||y>height||y<0) {
        reset();
    } 
    
    
  }
  
} 