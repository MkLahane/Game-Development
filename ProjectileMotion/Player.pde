class Player {
  Barrel barrel;
  //ArrayList<Rocket> rockets;
  Rocket rocket;
  String playerName;
  float health=200;
  PVector playerPos;
  
  Player(String _playerName,PVector p,PVector _playerPos) {
    playerName=_playerName;
    barrel=new Barrel(p);
    //rockets=new ArrayList<Rocket>();
    playerPos=_playerPos.get();
  } 
  
  void run(Player p) {
    
    //fill(255,0,0);
    //rect(barrel.start.x-100,barrel.start.y-200,10,health);
  
    barrel.show();
    /*for(Rocket r:rockets) {
        r.show();
        r.update();
        
    } */
    if(rocket!=null) {
      rocket.show();
      rocket.update();
      if(rocket.checkCollision(p)) {
        rocket=null;
        damage(p);
      } 
    }
    
    fill(200,0,255);
    noStroke();
    rect(playerPos.x,playerPos.y,50,150);
    
  } 
  
  void damage(Player p) {
    p.health-=20;
    return;
  } 
  
  void update() {
    fill(255);
    rect(width/2,680,barrel.power,20);
    barrel.update();
    PVector mouse=new PVector(mouseX,mouseY);
    barrel.lookFor(mouse);
    
  } 
  

 
  
  void Shoot() {
     //rockets.add(new Rocket(barrel.end.x,barrel.end.y,barrel.angle,barrel.power));
     rocket=new Rocket(barrel.end.x,barrel.end.y,barrel.angle,barrel.power);
  } 
  
  void SetAngle() {
    float p=map(mouseY,0,height,150,20);
    barrel.setPower(p);
  } 
} 