var mic;
var particles=[];
function setup() {
    createCanvas(600,600);
    mic=new p5.AudioIn();
    mic.start();
    for(var i=0;i<100;i++) {
      var   particle=new Particle();
      particles.push(particle);
    }
}

function draw() {
    background(0);
    var level=mic.getLevel();
    for(var i=particles.length-1;i>=0;i--) {
      particles[i].show();
      particles[i].update();
      if(particles[i].pos.x<0 || particles[i].pos.y<0 || particles[i].pos.x>width || particles[i].pos.y>height) {
        particles.splice(i,1);
      }
    }
    if(level>0.1) {
      particles.push(new Particle(level));

    }

}
