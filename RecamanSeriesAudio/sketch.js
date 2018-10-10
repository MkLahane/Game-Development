let i = 0;
let step = 1;
let numbersLanded = [];
let recamanSeq = [];
let osc;
let attackTime = 0.001;
let decayTime = 0.2;
let sustainPercent = 0.2;
let releaseTime = 0.5;
let attackLevel = 1.0;
let releaseLevel = 0.0;
let env;
function setup() {
  createCanvas(600, 600);
  recamanSeq[i] = 0;
  frameRate(5);
  numbersLanded[i] = true;
  // for (let i = 0; i < 20; i++) {
  //   addNumber();
  // }
  env = new p5.Env();
  env.setADSR(attackTime, decayTime, sustainPercent, releaseTime);
  env.setRange(attackLevel, releaseLevel);
  osc = new p5.Oscillator();


  osc.setType('sine');
  //osc.freq(240);
  osc.amp(env);
  osc.start();
  //env.play();
}



function addNumber() {
  i++;
  let next = recamanSeq[i - 1] - step;
  if (next < 0 || numbersLanded[next]) {
    next = recamanSeq[i - 1] + step;
  }
  numbersLanded[next] = true;
  recamanSeq[i] = next;
  let n = (next % 13) + 12;
  let f = pow(2, (n % 88) / 12) * 440;

  osc.freq(f);
  env.play();
  step++;
}

function draw() {

  addNumber();
}
