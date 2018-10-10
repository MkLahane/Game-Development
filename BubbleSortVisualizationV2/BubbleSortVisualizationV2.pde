int numOfBoxes = 100;
Box[] boxes;
float angle = 0;
int currentI = 0;
int checkingJ = currentI + 1;
void setup() {
  size(800, 700);
  boxes = new Box[numOfBoxes];
  for (int i = 0; i < boxes.length; i++) {
    boxes[i] = new Box(map(i, 0, boxes.length, 0, height / 2), random(0, TWO_PI));
  } 
  rectMode(CENTER);
  //for (int i = 0; i < boxes.length; i++) {
  //  for (int j = i + 1; j < boxes.length; j++) {
  //    if (boxes[i].value > boxes[j].value) {
  //      swap(boxes, i, j);
  //    } 
  //  } 
  //}
  
}


void swap(Box[] arr, int a, int b) {
  float temp = arr[a].value;
  arr[a].value = arr[b].value;
  arr[b].value = temp;
} 

void draw() {
  background(255);
  stroke(0);
  noFill();
  fill(255);
  strokeWeight(4);
  for (Box box : boxes) {
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(box.angle + angle);
    rect(0, 0, box.value * 2, box.value * 2);
    popMatrix();
  }
  //for (int i = 0; i < 100; i++) {
  //  if (currentI < boxes.length - 1) {
  //    if (boxes[currentI].value < boxes[checkingJ].value) {
  //      swap(boxes, currentI, checkingJ);
  //    } 
  //    checkingJ++;
  //  } else {
  //    //noLoop();
  //    println("sorted");
  //  } 
  //  if (checkingJ >= boxes.length) {
  //    currentI++;
  //    checkingJ = currentI + 1;
  //  }
  //}
  if (currentI < boxes.length - 1) {
    for (int j = currentI + 1; j < boxes.length; j++) {
      if (boxes[currentI].value < boxes[j].value) {
        swap(boxes, currentI, j);
      } 
    } 
  } 
  currentI++;
  
  angle += 0.01;
} 

class Box {
  float value;
  float angle;
  Box(float _value, float _angle) {
    value = _value;
    angle = _angle;
  }
}
