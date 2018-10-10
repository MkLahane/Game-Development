let spacing=1;
let circlePath=[];
let radius=200;
let morph=[];

function polarToCartesian(r,angle) {
  return createVector(r*cos(angle),r*sin(angle));
}

function setup() {
  createCanvas(500,500);
  angleMode(DEGREES);
  let i=0;
  for(let angle=0;angle<360;angle+=spacing) {
    var circleVec=polarToCartesian(radius,angle);
    circleVec.active=true;
    if(angle%120==0) {
      circleVec.fixed=true;
    }
    circlePath.push(circleVec);

  }
  console.log(circlePath.length);
}

function draw() {
  background(0);

  translate(width/2,height/2);
  rotate(30);
  strokeWeight(4);
  stroke(255);
  noFill();
  beginShape();
  for(let i=0;i<circlePath.length;i++) {
    if(circlePath[i].active) {
      vertex(circlePath[i].x,circlePath[i].y);
    }
  }
  endShape(CLOSE);
  let activeList=[];
  for(let i=0;i<circlePath.length;i++) {
    let vec=circlePath[i];
    if(vec.active && !vec.fixed ) {
      activeList.push(vec);
    }
  }



  if(activeList.length>0) {
    let index=0;
    let circleVec=activeList[index];
    circleVec.active=false;
  }else if(activeList.length<=0) {
    //console.log("asdad");
    for(let i=0;i<circlePath.length;i++) {
      let v=circlePath[i];
      if(!v.active && !v.fixed) {
        v.active=true;
      }
    }
  }

}
