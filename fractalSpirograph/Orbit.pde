class Orbit {
  float x;
  float y;
  float angle;
  float speed;
  float r;
  int n;
  float k;
  Orbit parent;
  Orbit child;
  Orbit(float _x,float _y,int _n,float _k,float _r) {
    this(_x,_y,_n,_r,null,_k);
  } 
  Orbit(float _x,float _y,int _n,float _r,Orbit p,float _k) {
    x=_x;
    y=_y;
    n=_n;
    k=_k;
    speed=(radians(pow(_k,n-1)))/resolution;
    angle=-PI/2;
    r=_r;
    parent=p;
  } 
  void show() {
    noFill();
    stroke(255,100);
    strokeWeight(1);
    ellipse(x,y,r*2,r*2);
  } 
  
  Orbit addOrbit() {
    float newR=r/3.0;
    float newX=x+r+newR;
    float newY=y;
    child=new Orbit(newX,newY,n+1,newR,this,k);
    return child;
  } 
  
  void update() {
    if(parent!=null) {
      angle+=speed;
      float rsum=r+parent.r;
      x=parent.x+cos(angle)*rsum;
      y=parent.y+sin(angle)*rsum;
    }
    
  } 
  
} 