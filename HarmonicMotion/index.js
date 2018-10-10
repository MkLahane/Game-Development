let angleA=0;
let angleB=0;
let angle=0;
let amplitude=200;

let fA=1;
let fB=4.3;

let ampA=300;
let ampB=300;
let speed=1;
let offset=90;
function setup() {
  createCanvas(600,600);

  angleMode(DEGREES);
}

function draw() {
  background(0,10);

  speed=map(mouseX,0,width,0,0.5);
  translate(width/2,height/2);
  let x=sin(fA*angleA+offset)*ampA;
  let y=sin(fB*angleB)*ampB;
  let r=map(sin(angleA),-1,1,0,255);
  let b=map(cos(angleB),-1,1,0,255);
  noStroke();
  fill(r,50,b);
  ellipse(x,y,20,20);
  //angle+=speed;
  angleA+=fA;
  angleB+=fB;


  fA=map(sin(angleA),-1,1,0.1,1.2);
  fB=map(cos(angleB),-1,1,0.1,1.2);



}
