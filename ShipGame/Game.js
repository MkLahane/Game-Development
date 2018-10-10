var ship;
var asteroids=[];
var bullets=[];
function setup() {
  createCanvas(window.innerWidth,window.innerHeight);
  ship=new Ship(width/2,height/2);
  for(var i=0;i<15;i++) {
    asteroids.push(new Asteroid());
  }
}
function draw() {
  background(0);


  for(var i=bullets.length-1;i>=0;i--) {
    bullets[i].show();
    bullets[i].update();
    for(var j=asteroids.length-1;j>=0;j--) {
       if(bullets[i].hits(asteroids[j])) {
         if(asteroids[j].r>10) {
           var newAsteroids=asteroids[j].breakup();
           asteroids=asteroids.concat(newAsteroids);
         }

         asteroids.splice(j,1);
         bullets.splice(i,1);
         break;
       }
     }
   }
  for(var i=0;i<asteroids.length;i++) {
    if(ship.hits(asteroids[i])) {
      //ship=new Ship(width/2,height/2);
      noLoop();
    }
    asteroids[i].show();
    asteroids[i].update();
    asteroids[i].edges();
  }
  ship.show();
  ship.turn();
  ship.update();
  ship.edges();


}
function keyReleased() {
  ship.setRotation(0);
}

function keyPressed() {
  if(key==' ') {
    bullets.push(new Laser(ship.pos.x,ship.pos.y,ship.heading))
  }
  if(keyCode==RIGHT_ARROW) {
    ship.setRotation(0.1);
  } else if(keyCode==LEFT_ARROW) {
    ship.setRotation(-0.1);
  } else if(keyCode==UP_ARROW) {
    ship.thrusting();
  }
}
