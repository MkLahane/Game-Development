class Rocket {
  float x;
  float y;
  float xvel;
  float yvel;
  float velocity=100;
  float dt=0.1;
  float acc=9.8;
  float angle=-PI/4;
  
  Rocket(float _x,float _y,float _angle,float vel) {
    x=_x;
    y=_y;
    velocity=vel;
    angle=_angle;
    xvel=velocity*cos(angle);
    yvel=velocity*sin(angle);
  } 
  
  void show() {
    fill(255);
    ellipse(x,y,20,20);
    
  }
  
  void update() {
    yvel=yvel+(acc*dt);
    x=x+(xvel*dt);
    y=y+(yvel*dt)+0.5*acc*(dt*dt);
    
  } 
  
  boolean checkCollision(Player p) {
    if(x>p.playerPos.x && x+20<p.playerPos.x+50 && y>p.playerPos.y && y+20<p.playerPos.y+150) {
      return true;
    } else {
      return false;
    } 
  } 
  
} 