class Rectangle {
  float left;
  float right;
  float top;
  float bottom;
  
  Rectangle(float x,float y,float w,float h) {
    update(x,y,w,h);
    
  } 
  void update(float x,float y,float w,float h) {
    left=x;
    right=x+w;
    top=y;
    bottom=y+h;
  } 
  
  boolean intersects(Rectangle other) {
    return !(left>=other.right || right <=other.left || top>=other.bottom|| bottom<=other.top);
    
  } 
  
} 