class Group {
  float x;
  float y;
  float h;
  float w;
  String groupName="";

  Group(int i,int j,float _w,float _h) {
    w=_w;
    h=_h;
    x=j*w;
    y=i*h;
  } 
  void show() {
    stroke(255);
    noFill();
    rect(x,y,w,h);
  } 
} 