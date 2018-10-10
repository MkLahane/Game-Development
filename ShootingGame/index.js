let enemies=[];
let timer=0;
let delayTime=5;
let nextTime=0;
let player;
let playerBulletSound;
let enemyBulletSound;
let backgroundMusic;
let playerExplosionSound;
let enemyExplosionSound;

let shootingRight;
let shootingLeft;

let shootingEnemyLeft;
let shootingEnemyRight;

function preload() {
  playerBulletSound=loadSound('weapon_player.wav');
  enemyBulletSound=loadSound('weapon_player.wav');
  backgroundMusic=loadSound('music_background.wav');
  playerExplosionSound=loadSound('explosion_player.wav');
  enemyExplosionSound=loadSound('explosion_enemy.wav');
  enemyBulletSound.amp(0.1);
  shootingRight=loadImage('shootingRight.png');
  shootingLeft=loadImage('shootingLeft.png');
  shootingEnemyRight=loadImage('enemyRight.png');
  shootingEnemyLeft=loadImage('enemyLeft.png');
}

function setup() {
  createCanvas(600,600);
  newEnemy();
  player=new Player(createVector(width/2,height/2));
  backgroundMusic.play();
  backgroundMusic.loop();

}
function draw() {
  background(255);

  if(player.health>0) {
    player.show(mouseX);
    console.log(mouseX,mouseY);
  }
  if(player.health<=0){
    noLoop();
    playerExplosionSound.play();
    backgroundMusic.stop();
  }

  player.update();
  player.lookAt(createVector(mouseX,mouseY));
  for(let i=enemies.length-1;i>=0;i--) {
    enemies[i].show();
    enemies[i].point(player.pos);
    enemies[i].hit(player);
    player.hit(enemies[i]);
    if(enemies[i].dead()) {
      enemyExplosionSound.play();
      enemies.splice(i,1);
    }
  }

  if(frameCount%120==0) {
    addEnemy();
  }
}

function mousePressed() {
  player.shoot();
  playerBulletSound.play();
  // if(playerBulletSound.isPlaying()) {
  //   playerBulletSound.stop();
  // }else {
  //   playerBulletSound.play();
  // }
}

function addEnemy() {
  let total=2;
  let count=0;
  let protection=0;
  while(count<total) {
    let enemy=newEnemy();
    if(enemy!=null) {
      enemies.push(enemy);
      return;
    }
    protection++;
    //console.log(protection);
    if(protection>100) {
      break;
    }
  }
}

function newEnemy() {
  let edge=60;
  let x=edge;
  if(random(1)<0.5) {
    x=width-edge;
  }
  let y=random(0,height);
  let valid=true;
  for(let i=0;i<enemies.length;i++) {
    let d=dist(x,y,enemies[i].loc.x,enemies[i].loc.y);
    if(d<enemies[i].r+enemies[i].r) {
      valid=false;
      break;
    }
  }
  if(valid) {
    return new Enemy(x,y,floor(random(20,120)));
  }else {
    return null;
  }
}
