var rule1={
  a:"F",
  b:"FF+[+F-F-F]-[-F+F+F]"
}

var angle;
var len=100;
var axiom="F";
var sent=axiom;
function setup() {
  createCanvas(600,600);
  background(0);
  angle=radians(25.7);
  var button=createButton("Generate");
  createP(axiom);
  turtle();
  button.mousePressed(generate);
}


function  generate() {
  len*=0.5;
  var nextSent="";
  for(var i=0;i<sent.length;i++) {
    var current=sent.charAt(i);
    if(current==rule1.a) {
      nextSent+=rule1.b;
    }else {
      nextSent+=current;
    }
  }
  sent=nextSent;
  createP(sent);
  turtle();
}

function turtle() {

  background(0);
  resetMatrix();
  translate(width/2,height);
  stroke(255);
  for(var i=0;i<sent.length;i++) {
    var current=sent.charAt(i);
    if(current=="F") {
      line(0,0,0,-len);
      translate(0,-len);
    }else if(current=="+") {
      rotate(angle);
    }else if(current=="-") {
      rotate(-angle);
    }else if(current=="[") {
      push();
    }else if(current=="]") {
      pop();
    }
  }
}
