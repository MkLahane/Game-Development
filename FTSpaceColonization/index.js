var tree;
var max_dist=100;
var min_dist=10;
function setup() {
  createCanvas(1000,700);
  tree=new Tree();
}
function draw() {
  background(0);
  tree.show();
  tree.grow();
}
