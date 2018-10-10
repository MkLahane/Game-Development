String txt;
float y;
void setup() {
  //size(1200, 700, P3D);
  fullScreen(P3D);
  String[] lines = loadStrings("text.txt");
  txt = join(lines, "\n");
  y = height / 2;
} 

void draw() {
  background(0);
  translate(width / 2, height / 2);
  rotateX(PI / 4);
  fill(218, 238, 75);
  textSize(64);
  textAlign(CENTER);
  float w = width * 0.7;
  text(txt, -w / 2, y, w, height * 10);
  y-=1;
} 
