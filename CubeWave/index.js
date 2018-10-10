let angle=0;
let spacing=20;
let magic_angle;
let maxDist;
function setup() {
  createCanvas(600,600,WEBGL);
  magic_angle=atan(cos(QUARTER_PI));
  maxDist=dist(0,0,250,250);
}

function draw() {
  background(100);
  //ortho(-200,200,200,-200,0,500);
  ortho(-450,450,450,-450,0,1000);

  //isometric view
  rotateY(magic_angle);
  rotateX(-QUARTER_PI);


  directionalLight(0,0,200,0,1,0);
  directionalLight(170,0,170,0,-1,0);
  directionalLight(0,100,100,1,0,0);
  directionalLight(100,0,50,-1,0,0);
  //translate(0,0,400);
  //rotateX(PI/8);

  //rotateX(angle);
  //stroke(0);
  //fill(255);
  ambientMaterial(255);
  //normalMaterial();
  //noFill();
  for(let z=0;z<height;z+=spacing) {
    for(let x=0;x<width;x+=spacing) {
      push();
      let d=dist(x,z,width/2,height/2);
      let offset=map(d,0,maxDist,-PI,PI);
      let a=angle+offset;
      let h=floor(map(sin(a),-1,1,50,400));
      //fill(255);
      //noFill();
      translate(x-width/2,0,z-height/2);
      box(spacing-2,h,spacing-2);
      //rect(x-width/2+spacing/2,spacing-2,10,h);
      pop();
    }

  }

  angle-=0.08;
}
