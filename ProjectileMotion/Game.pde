class Game {
  Player player1;
  Player player2;
  
  Player currentPlayer;
  
  Game() {
    player1=new Player("Player 1",new PVector(100,600),new PVector(50,500));
    player2=new Player("Player 2",new PVector(1300,600),new PVector(1300,500));
    currentPlayer=player1;
    
  } 
  
  void runGame() {
    //current Player's action
    player1.run(player2);
    player2.run(player1);
     
 
    
    HealthBar();
    
    PVector textPos;
    if(currentPlayer.playerName.equals(player1.playerName)) {
      textPos=new PVector(150,300);
    } else {
      textPos=new PVector(1050,300);
    } 
    
    fill(0,255,0);
    textSize(50);
    text(currentPlayer.playerName+" turn!!",textPos.x,textPos.y);
    currentPlayer.update();
    
  } 
  
  void Shoot() {
    currentPlayer.Shoot();
    if(currentPlayer.playerName.equals(player1.playerName)) {
      
      currentPlayer=player2;
    } else {
      currentPlayer=player1;
    } 
  
  } 
  void SetAngle() {
    currentPlayer.SetAngle();
  } 
  void HealthBar() {
    noStroke();
    fill(255,0,0);
    rect(50,200,10,player1.health);
    rect(1350,200,10,player2.health);
    fill(255);
    textSize(10);
    text(player1.health,50,200);
    text(player2.health,1340,200);
    
  } 
} 
