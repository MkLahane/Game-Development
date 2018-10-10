var Engine=Matter.Engine,
    World=Matter.World,
    Bodies=Matter.Bodies;
    Body=Matter.Body;
var boxes=[];
var engine;
var world;
var obstacles=[];
function setup() {
  createCanvas(400,400);
  engine=Engine.create();
  world=engine.world;
  var box1=new Box(200,200,20);
  boxes.push(box1);
  obstacles.push(new Boundary(150,height-50,width*0.7,50,0.3));
  obstacles.push(new Boundary(270,height/2,width*0.7,50,-0.3));
  //World.add(world,obstacle);
  Engine.run(engine);
  console.log(box1.body);
  //console.log(obstacle)
}
function draw() {
  background(0);
  Engine.update(engine);
  for(var i=0;i<obstacles.length;i++) {
    obstacles[i].show();
  }
  for(var i=0;i<boxes.length;i++) {
    boxes[i].show();
  }

}
function mousePressed() {
  boxes.push(new Box(mouseX,mouseY,20));


}
