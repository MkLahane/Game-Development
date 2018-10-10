function Enemy(x,y,fr) {
  this.fireRate=fr;
  this.health=50;
  this.loc=createVector(x,y);
  this.r=50;
  this.angle=0;
  this.bullets=[];
  this.img=null;
  this.barrel=new Barrel(this.loc,this.angle,20);

  this.show=function() {
    fill(0);
    // ellipse(this.loc.x,this.loc.y,this.r,this.r);
    /*if(this.loc.x>=width/2) {
      this.img=shootingEnemyLeft;
    }else {
      this.img=shootingEnemyRight;
    }*/
    this.img=shootingEnemyRight;
    push();
    imageMode(CENTER);
    translate(this.loc.x,this.loc.y);
    rotate(this.angle);
    if(this.img!=null) {
      image(this.img,0,0,40,40);
    }
    pop();
    if(this.barrel!=null) {
      this.barrel.show();
    }
    this.updateAngle();
    for(let bullet of this.bullets) {
      bullet.show();
      bullet.update();
    }
  }

  this.updateAngle=function() {
    //this.angle+=0.1;
    this.barrel.updateEnd(this.angle);
  }

  this.point=function(pos) {
    let desired=p5.Vector.sub(pos,this.loc);
    desired.normalize();
    this.angle=desired.heading();
    if(frameCount%this.fireRate==0) {
      enemyBulletSound.play();
      this.shoot();
    }
  }

  this.shoot=function() {
    this.bullets.push(new Bullet(this.barrel.end,20,this.angle,createVector(2,3)));
  }

  this.hit=function(pl) {
    for(let i=this.bullets.length-1;i>=0;i--) {
      if(this.bullets[i].hit(pl.pos,pl.r)) {
        if(pl.health>=0) {
          pl.health-=1;
        }
        //console.log(pl.health);
        this.bullets.splice(i,1);
      }
    }
  }

  this.dead=function() {
    return (this.health<=0);
  }

}
